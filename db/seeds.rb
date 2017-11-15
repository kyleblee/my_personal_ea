celia = Contact.create(name: "Celia")
vic = Contact.create(name: "Vic")
joe = Contact.create(name: "Joe")
matt = Contact.create(name: "Matt Sincaglia")
sara = Contact.create(name: "Sara K")
courtney = Contact.create(name: "Courtney")
justin = Contact.create(name: "Justin")

kyle = User.find_by(username: "kylelee")

kyle.contacts << celia
kyle.contacts << vic
kyle.contacts << joe
kyle.contacts << matt
kyle.contacts << sara
kyle.contacts << courtney
kyle.contacts << justin

amazon_talk = LastInteraction.create(date: "11/15/2017", details: "Talking about what we use the Amazon Prime account for.")
dinner_on_saturday = LastInteraction.create(date: "11/8/2017", details: "Having dinner with the family and Vic.")
driving = LastInteraction.create(date: "11/10/2017", details: "Talking about driving fast cars and such.")
last_day_at_redpeg = LastInteraction.create(date: "11/2/2017", details: "Saying goodbye to everyone on the last day and getting lunch with Matt.")
weekend_at_the_lake = LastInteraction.create(date: "9/14/2017", details: "Having an amazing weekend at Deep Creek Lake with awesome people.")

celia.last_interactions << amazon_talk
vic.last_interactions << dinner_on_saturday
joe.last_interactions << driving
matt.last_interactions << last_day_at_redpeg
justin.last_interactions << weekend_at_the_lake

celia.location = "Paeonian Springs"
vic.email = "vic@gmail.com"
joe.phone_number = "(111) 111-1111"
matt.expertise = "Brand Strategy, business development, taste in alcohol, soccer."
sara.preferences = "Vodka and having a good time."
