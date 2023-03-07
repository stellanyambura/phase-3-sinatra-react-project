puts "🌱 Seeding spices..."

# Seed your database here
joe = User.create(first_name: "joe", last_name: "Doe", email: "joe@example.com", password_digest: "1234")

dashboard = Project.create(title: "Dashboard", description: "lorem ipsum dolor sit amet, consectetur adipiscing elit", image_url: "http://somathing.com",project_Github_url: "https://github.com/", user_id: joe.id)
bank = Project.create(title: "bank", description: "lorem ipsum dolor sit amet, consectetur adipiscing elit", image_url: "http://somathing.com",project_Github_url: "https://github.com/", user_id: joe.id)
password_generator = Project.create(title: "password_generator", description: "lorem ipsum dolor sit amet, consectetur adipiscing elit", image_url: "http://somathing.com",project_Github_url: "https://github.com/", user_id: joe.id)
tic_tac_toe = Project.create(title: "tic_tac_toe", description: "lorem ipsum dolor sit amet, consectetur adipiscing elit", image_url: "http://somathing.com",project_Github_url: "https://github.com/", user_id: joe.id)
flatacuties = Project.create(title: "flatacuties", description: "lorem ipsum dolor sit amet, consectetur adipiscing elit", image_url: "http://somathing.com",project_Github_url: "https://github.com/", user_id: joe.id)


ux_design = Skill.create(name: "ux_design", description: "ux designing", user_id: joe.id)
full_stack_developer = Skill.create(name: "full_stack_developer", description: "ux designing", user_id: joe.id)
frontend_developer = Skill.create(name: "frontend_developer", description: "ux designing", user_id: joe.id)
backend_developer = Skill.create(name: "backend_developer", description: "ux designing", user_id: joe.id)
cyber_security = Skill.create(name: "cyber_security", description: "ux designing", user_id: joe.id)

puts "✅ Done seeding!"
