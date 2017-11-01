class User
	attr_accessor
	def initialize(attr = {})
		attr.each do |key, value|
			self.instance_variable_set("@#{key}", value)
			self.class.send(:attr_accessor, key)
		end
	end

	def self.find(id)
		user = `sqlite3 orm_test.db "SELECT * FROM users WHERE id = #{id};"`
		user_array = user.split('|')
		keys = `sqlite3 orm_test.db "PRAGMA table_info(users);"`
		keys_arr = keys.split("\n")
		key_array = keys_arr.map { |str| str.split('|')[1].to_sym}
		user_hash = Hash[key_array.zip(user_array)]
		User.new(user_hash)
	end

	def save
		string = ''
		self_vars = self.instance_variables
		vars = self_vars.map do |instance_var|
			column = instance_var.to_s.delete('@')
			value = self.instance_variable_get(instance_var)
			"#{column} = '#{value}'"
		end
		if !defined? @id
			keys = self.instance_variables.map{|k| k.to_s.delete('@')}.join(', ')
			vals = instance_variables.map{|k| "'#{instance_variable_get(k)}'"}.join(', ')
			`sqlite3 orm_test.db "INSERT INTO users (#{keys}) VALUES (#{vals});"`
		else
			sql = vars.join(', ')
			`sqlite3 orm_test.db "UPDATE users SET #{sql} WHERE id = #{@id};"`
		end
	end

	def destroy
		`sqlite3 orm_test.db "DELETE FROM users WHERE id = #{@id};"`
	end
end

user = User.new(first_name: 'Casey', last_name: 'Stinnet')

user.first_name = 'asdf'
user.save
# user.destroy
p user