account = Account.where(name: 'Takehome', slug: 'default').first_or_create

users = []
['Dean Martin', 'Aubry Plaza', 'Dolph Lundgren'].each do |name|
  users << account.users.where(name: name).first_or_create
end

Account.all.each do |account|
  3.times do |n|
    account.tickets.create({
      subject: "My printer is on fire!",
      body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
      problem_id: rand(10) < 4 ? account.tickets.reload.sample : nil,
      user_id: users.sample.id
    })
  end
end
