# By using the symbol ':user', we get Factory Girl to simulate the User model.

Factory.define :user do |user|
	user.name										"Jason Preston"
	user.email									"jason@prestons.me"
	user.password								"foobar"
	user.password_confirmation 	"foobar"
end
