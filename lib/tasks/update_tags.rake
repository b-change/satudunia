namespace :update_tags do
  desc "To update Default tags"
  task :updateDefaultTags => :environment do

    Tag.destroy_all
    ["casual_partners","family","friends","regular_partners","partying","sex","situation","compliance","regular_access_to_medication","dating","family","friends","minimising-risk","safer_sex","accessing_medication","cost","selecting_medication","side_effects","clinics","cost","doctors","migration","tourism","fitness","nutrition","health_checks","health_insurance","inclusion_&_iscrimination"].each do |tag|
      Tag.create(:name => tag)
    end
    @tags={:disclosure=>["casual_partners","family","friends","regular_partners"],
    :drugs=>["partying","sex"],:first_diagnosis=>["situation"],
    :maintaining_treatment=>["compliance","regular_access_to_medication"],
    :relationships=>["dating","family","friends"],:sex=>["minimizing-risk","safer_sex"],
    :starting_medication=>["accessing_medication","cost","selecting_medication",
    "side_effects"],:starting_treatment=>["clinics","cost","doctors"],
    :travel=>["migration","tourism"],:well_being=>["fitness","nutrition"],
    :work=>["health_checks","health_insurance","inclusion_&_iscrimination"]}
    # conditional statemnets
    if Group.last.update_attributes(:default_tags=>@tags)
      puts "Default tags updated"
    else
      Puts "Something went wrong"
    end
  end

  desc "To update Default tags Questions"
  task :updateTagsQuestions => :environment do
    # default tags
    # to delete all the question
    # Question.delete_all
    # @tags= Group.last.default_tags
    # @user = User.first
    # @group = Group.first
    # @tags.each do |tag|
    #   # dummy question
    #   # if tag.include?(params[:type])
    #   #   @tag_data << tag[0]
    #   # end
    #   if Question.any_in(:tags=>[tag[0].to_s]).count.equal? 0
    #     question = "#{tag[0].to_s} First question Lorem Ipsum "
    #     question1 = "#{tag[0].to_s} Second questions All the Lorem Ipsum" 
    #     body = "#{tag[0].to_s} First body the Lorem Ipsum" 
    #     body1 = "#{tag[0].to_s} second body Lorem Ipsum " 
    #     questionHash = {title: question, tags: tag[0].to_s, group_id: @group.id, body: body}
    #     questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
    #     @user.questions.create!(questionHash)
    #     @user.questions.create!(questionHash1)
    #     puts "Question created main tag"
    #   end
    #   unless tag[1].nil?
    #     tag[1].each do |subtag|
    #       if Question.any_in(:tags=>[subtag.to_s]).count.equal? 0
    #         question = "#{subtag.to_s} First question Lorem Ipsum" 
    #         question1 = "#{subtag.to_s} Second questions All the Lorem Ipsum" 
    #         body = "#{subtag.to_s} First body the Lorem Ipsum"
    #         body1 = "#{subtag.to_s} second body Lorem Ipsum " 
    #         questionHash = {title: question, tags: [subtag.to_s], group_id: @group.id,body: body}
    #         questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
    #         @user.questions.create!(questionHash)
    #         @user.questions.create!(questionHash1)
    #         puts "Question created for subtag"
    #       end
    #     end
    #   end
    #   # conditional statement ends here
    # end
    # # loop ends here
    namespace :update_tags do
  desc "To update Default tags"
  task :updateDefaultTags => :environment do

    @tags={:disclosure=>["casual_partners","family","friends","regular_partners"],
    :drugs=>["partying","sex"],:first_diagnosis=>["situation"],
    :maintaining_treatment=>["compliance","regular_access_to_medication"],
    :relationships=>["dating","family","friends"],:sex=>["minimising-risk","safer_sex"],
    :starting_medication=>["accessing_medication","cost","selecting_medication",
    "side_effects"],:starting_treatment=>["clinics","cost","doctors"],
    :travel=>["migration","tourism"],:well_being=>["fitness","nutrition"],
    :work=>["health_checks","health_insurance","inclusion_&_iscrimination"]}
    # conditional statemnets
    if Group.last.update_attributes(:default_tags=>@tags)
      puts "Default tags updated"
    else
      Puts "Something went wrong"
    end
  end

  desc "To update Default tags Questions"
  task :updateTagsQuestions => :environment do
    # default tags
    # to delete all the question
    # Question.delete_all
    # @tags= Group.last.default_tags
    # @user = User.first
    # @group = Group.first
    # @tags.each do |tag|
    #   # dummy question
    #   # if tag.include?(params[:type])
    #   #   @tag_data << tag[0]
    #   # end
    #   if Question.any_in(:tags=>[tag[0].to_s]).count.equal? 0
    #     question = "#{tag[0].to_s} First question Lorem Ipsum "
    #     question1 = "#{tag[0].to_s} Second questions All the Lorem Ipsum" 
    #     body = "#{tag[0].to_s} First body the Lorem Ipsum" 
    #     body1 = "#{tag[0].to_s} second body Lorem Ipsum " 
    #     questionHash = {title: question, tags: tag[0].to_s, group_id: @group.id, body: body}
    #     questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
    #     @user.questions.create!(questionHash)
    #     @user.questions.create!(questionHash1)
    #     puts "Question created main tag"
    #   end
    #   unless tag[1].nil?
    #     tag[1].each do |subtag|
    #       if Question.any_in(:tags=>[subtag.to_s]).count.equal? 0
    #         question = "#{subtag.to_s} First question Lorem Ipsum" 
    #         question1 = "#{subtag.to_s} Second questions All the Lorem Ipsum" 
    #         body = "#{subtag.to_s} First body the Lorem Ipsum"
    #         body1 = "#{subtag.to_s} second body Lorem Ipsum " 
    #         questionHash = {title: question, tags: [subtag.to_s], group_id: @group.id,body: body}
    #         questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
    #         @user.questions.create!(questionHash)
    #         @user.questions.create!(questionHash1)
    #         puts "Question created for subtag"
    #       end
    #     end
    #   end
    #   # conditional statement ends here
    # end
    # # loop ends here
    Question.destroy_all
    User.first.questions.create!(:title => 'Why did the IRS issue internal guidance regarding offshore activities now?', :body => "IRS Criminal Investigation has determined preliminary acceptance into the voluntary disclosure program", :tags=>"disclosure", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why should I make a voluntary disclosure?', :body => "Taxpayers with undisclosed foreign accounts or entities should make a voluntary disclosure because it enables them to become compliant, avoid substantial civil penalties and generally eliminate the risk of criminal prosecution.", :tags=>"disclosure", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Will I have to file or amend my old tax returns?', :body => "In addition, any inaccurate returns for any of the 6 years must be amended by the taxpayer.", :tags=>"disclosure", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What should I do if I am having difficulty obtaining my records from overseas?', :body => " If assistance is needed, the agent assigned to a case will work with the taxpayer in preparing a request that should be acceptable to the foreign bank", :tags=>"disclosure", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How does the penalty framework work?  Can you give us an example?', :body => "Although the amount on deposit may have been in the account for many years, it is assumed for purposes of the example that it is not unreported income", :tags=>"disclosure", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are you OK with having protected sex?', :body => "The last thing you want out of this time of exploration is a painful, possibly lifelong, STD.", :tags=>"casual_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Do you feel a sense of value in who you are, regardless of what any other man/woman may think?', :body => "You may not TOTALLY be in a place where you believe in yourself, but you must have some strong feelings of self worth before beginning a nostrings attached relationship.", :tags=>"casual_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What do I plan to do with this for the long run?', :body => "Ill be honest, thats the toughest one to answer because it requires real thought and planning", :tags=>"casual_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are you being honest with yourself about what you want?', :body => "The last thing you need after walking through the bowels of Divorce Hell is to start emotionally reeling again.", :tags=>"casual_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are you prepared to be honest with your sex partner?', :body => "Reiterate your boundaries if need be. And, be ready to exit the relationship to save his/her feelings and avoid any potential drama.", :tags=>"casual_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is there a authority for her to submit to?', :body => "It happens frequently, and especially in the realm of spiritual authority.", :tags=>"family", :group_id=>Group.first.id)
    User.first.questions.create!(:title => "If the woman is to submit, isnt she playing a lesser role?", :body => "Every member of the family not just the wife comes under the command to submit", :tags=>"family", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How will you know if youve had successful life?', :body => "Do you have good friends who practice religions that are different from ours", :tags=>"family", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What traits do you most admire in other people?', :body => "Do you think its a good idea for them to look up their birth parents", :tags=>"family", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Whats the best thing about our family?', :body => "If a violence prone husband becomes agitated and abusive, the wife should remove herself from danger, by leaving the home if necessary.", :tags=>"family", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What characteristics describe a true friend?', :body => "You know, it can be hard to find out if hes telling the truth or not. ", :tags=>"friends", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What flirty questions may you ask your crush?', :body => "These are some fun, flirty questions that you can ask a boy or girl that you like, or dont like.", :tags=>"friends", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should you tell your friend that you are in love with her?', :body => "If you truly love her tell her. The easiest way is to just tell her straight forward.", :tags=>"friends", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How would your friends describe you?', :body => "They possess everything you desire in a mate. If you want someone with a good job", :tags=>"friends", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What does it mean when a guy says he wants to love you up?', :body => "It depends on the guy, of course, but in general it means that he wants to be as intimate with you as possible", :tags=>"friends", :group_id=>Group.first.id)
    User.first.questions.create!(:title => "I need to change one of my partners license type from Partner to a regular CRM one.", :body => "Has any one done this already? Any step by step to not forget anything?", :tags=>"regular_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV be transmitted through insect bite?', :body => "No, Insects can NOT transmit HIV. Research has shown that HIV does not replicate or survive well in insects", :tags=>"regular_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What if I only use drugs on the weekend? Is really that bad?', :body => "Recreational or occasional drug use can be just as dangerous as an addictive pattern of behavior. In particular, excessive alcohol or stimulant (meth) use can be damaging even on an intermittent basis. These behaviors can be associated with immune system damage, lack of medication or treatment adherence, infection, organ damage, and overdose. Some of these effects can be seen even if a person only uses them on the weekends or when out partying. Sometimes this behavior is more dangerous because it leads to a greater loss of control and more risky behavior.", :tags=>"regular_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why does my provider want to order so many tests?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"regular_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What illnesses caused germs in food and water do people with HIV commonly get?', :body => "Germs in food and water that can make someone with HIV ill include E.coli, Salmonella, Campylobacter, Listeria and Cryptosporidium. They can cause diarrhea, upset stomach, vomiting, stomach cramps, fever, headache, muscle pain, bloodstream infection, meningitis, or encephalitis.", :tags=>"regular_partners", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are you currently doing to help manage your HIV and any symptoms you or other therapies?', :body => "Examples may include prescription medicines, over the counter products, and non drug therapies such as diet modification.", :tags=>"drugs", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How well does your current treatment regimen treat any significant symptoms are of your condition?', :body => "physical change to your body because of treatment, going to the hospital for treatment, etc", :tags=>"drugs", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What do you believe are the benefits of participating in an HIV cure research study?', :body => "associated with participation in an HIV cure research study include common side effects such as nausea and fatigue, and less common but serious adverse events such as blood clots, infection, seizures and cancer", :tags=>"drugs", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are there specific activities that are important to you but that you cannot like because of your?', :body => "activities may include sleeping through the night, daily hygiene, driving", :tags=>"drugs", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How should the informed consent clearly communicate and development of treatments?', :body => "In particular, how should the informed consent describe a study if there is very limited understanding about how the medications or interventions may affect participants or what are the potential risks of those interventions or medications", :tags=>"drugs", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from kissing?', :body => "No. You cannot get HIV from casually kissing someone (or vice versa) who has HIV. Skin is a greater barrier against HIV. It is not recommended to engage long, open mouth kissing French Kissing with someone who has HIV and one of you has an open sore in or around the mouth.", :tags=>"partying", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get AIDS from sharing a cup or shaking hands with someone who has HIV or AIDS?', :body => "HIV is found only in body fluids, so you cannot get HIV by shaking someones hand or giving them a hug (or by using the same toilet or towel). While HIV is found in saliva, sharing cups or utensils has never been shown to transmit HIV.", :tags=>"partying", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV also be transmitted through an insect bite?', :body => "No, Insects can NOT transmit HIV. Research has shown that HIV does not replicate or survive well in insects. In addition, blood eating insects digest their food and do not inject blood from the last person they bite into the next person.", :tags=>"partying", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from hot tubs or steam rooms?', :body => "No, HIV does not survive outside the body, and fluids like sweat and saliva that are typically secreted during these activities have never been shown to transmit HIV.", :tags=>"partying", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'my doctor says i have thrush but not HIV', :body => "Hello, i would be very very greatful for a reply.Almost one year ago i had a negative HIV test almost ten months after the last time i had unprotected sex with a guy. About 2.5 months ago my tongue got very sore and tingly especially when i eat...", :tags=>"partying", :group_id=>Group.first.id)
    User.first.questions.create!(:title => "How can I tell if Im infected with HIV? What are the symptoms?", :body => "The only way to determine for sure whether you are infected is to be tested for HIV infection. You cannot rely on symptoms to know whether or not you are infected with HI", :tags=>"sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How is HIV passed from one person to another?', :body => "HIV transmission can occur when blood, semen (including pre seminal fluid, or pre cum), vaginal fluid, or breast milk from an infected person enters the body of an uninfected person. HIV can enter the body through a vein (e.g., injection drug use), the anus or rectum, the vagina, the penis, the mouth, other mucous membranes (e.g., eyes or inside of the nose), or cuts and sores. Intact, healthy skin is an excellent barrier against HIV and other viruses and bacteria.", :tags=>"sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from kissing on the cheek?', :body => "HIV is not casually transmitted, so kissing on the cheek is very safe. Even if the other person has the virus, your unbroken skin is a good barrier. No one has become infected from such ordinary social contact as dry kisses, hugs, and handshakes", :tags=>"sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why is injecting drugs a risk for HIV?', :body => "At the start of every intravenous injection, blood is introduced into needles and syringes. HIV can be found in the blood of a person infected with the virus. The reuse of a blood contaminated needle or syringe by another drug injector (sometimes called direct syringe sharing) carries a high risk of HIV transmission because infected blood can be injected directly into the bloodstream.", :tags=>"sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How can people who use injection drugs reduce their risk for HIV infection?', :body => "Stop using and injecting drugs. ", :tags=>"sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why are Microbicides an Important Part of the Solution?', :body => "Although a range of effective prevention strategies exists, they are not doing enough to slow the spread of HIV, especially among women.Due to a mix of biology and social realities, women and girls are particularly vulnerable to infection, yet they lack the tools they need to protect their health. ", :tags=>"first_diagnosis", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'I dont believe I am at high risk. Why should I get tested?', :body => "Some people who test positive for HIV were not aware of their risk. Thats why CDC recommends that providers in all health care settings make HIV testing a routine part of medical care for patients aged 13 to 64, unless the patient declines (opts out). This practice would get more people tested and help reduce the stigma around testing.", :tags=>"first_diagnosis", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'When should I get tested?', :body => "The immune system usually takes 2 to 8 weeks to make antibodies against HIV (the average is 25 days). Although most HIV tests look for these antibodies", :tags=>"first_diagnosis", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What kinds of tests are available, and how do they work?', :body => "The most common HIV test is the antibody screening test (immunoassay), which tests for the antibodies that your body makes against HIV. The immunoassay may be conducted in a lab or as a rapid test at the testing site. It may be performed on blood or oral fluid (not saliva).", :tags=>"first_diagnosis", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What should I expect when I go in for an HIV test?', :body => "When its time to take the test, a health care provider will take your sample (blood or oral fluid) and you may be able to wait for the results (if its a rapid HIV test). If the test comes back negative, and you havent had an exposure for 3 months,  you can be confident youre not infected with HIV.", :tags=>"first_diagnosis", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why does my provider want to go order so many tests?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"situation", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Most HIV+ individuals have been or will be required to join a Health Care plan', :body => "The process to include the HIV+ population in Medicaid Managed Care began in NYC (August 2010) and will be continued to the rest of ", :tags=>"situation", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is it easy to get HIV?', :body => "No. HIV is not like the flu or a cold. It is not passed through casual contact or by being near a person who is infected.", :tags=>"situation", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why cant you get HIV from a mosquito bite?', :body => "There is not sufficient viral load, and the mosquitos blood is not compatible with the virus.", :tags=>"situation", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can you contract HIV from swimming in a pool with a person who is HIV infected?', :body => "No, there is not sufficient viral load and the chlorine will kill the virus.", :tags=>"situation", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should my baby get the same vaccines (needles or shots) as other babies?', :body => "Yes. Your baby should follow the same vaccine schedule as other babies.", :tags=>"maintaining_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What should I know about nutrition?', :body => "Nutrition plays an important role in maintaining health, especially for people living with HIV infection", :tags=>"maintaining_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV be prevented?', :body => "Since we know the ways that HIV is spread, we know how to keep people from getting infected. Contact with blood, semen or vaginal fluids should be AVOIDED and mothers with HIV should not breast feed their infants. Gloves should be warn when contact with blood is likely to occur. In the event of an accidental exposure to blood, immediate washing of the area with soap and water usually provides adequate protection unless the blood is able to enter the skin through an open wound", :tags=>"maintaining_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is there a place I can go to learn more about HIV terms?', :body => "Yes, the FXB Center includes a glossary that can be used to search out unfamiliar words or medical terms related to HIV infection.", :tags=>"maintaining_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Having an undetectable viral load in the blood does not possibility of transmitting the virus', :body => "because levels of HIV in the blood and semen or vaginal secretions are poorly correlated", :tags=>"maintaining_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What was your biggest worry about having child while being HIV positive?', :body => "I was afraid that my baby would be positive.", :tags=>"compliance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'For people with HIV, it plays a vital role in processing the drugs used to treat HIV.', :body => "Some people with HIV also have hepatitis B or hepatitis C, viruses that can cause inflammation of the liver. Some medicines, including some anti HIV drugs, can also affect your liver", :tags=>"compliance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What information must be given to a person get before an HIV test is given?', :body => "HIV is the virus that causes AIDS. The only way to know if you have HIV is to be tested.", :tags=>"compliance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What information must be provided at the time HIV test results are received?', :body => "When test results are given, persons who test negative must be provided with information about:", :tags=>"compliance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is confidential HIV related information?', :body => "Has one of these conditions, including information on the individuals contacts.", :tags=>"compliance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What Are the Symptoms of HIV Infection?', :body => "There are no specific symptoms of an HIV infection. In fact, some people may never develop symptoms and for those that do, most of these symptoms will usually go away after a few days, or at most, a couple of weeks.", :tags=>"regular_access_to_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How does HIV attack an immune system?', :body => "HIV attaches itself to a T cell and enters it. Once inside the T cell, HIV is able to multiply, which eventually leads to the destruction of the T cell. As more and more T cells become infected by HIV and destroyed, the immune system is weakened and becomes less able to fight off germs and bacteria.", :tags=>"regular_access_to_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How should the informed consent clearly communicate to you the  of an HIV cure research study?', :body => "In particular, how should the informed consent describe a study if there is very limited understanding about how the medications or interventions may affect participants or what are the potential risks of those interventions or medications", :tags=>"regular_access_to_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How do I know if I have an immunodeficiency disorder?', :body => "Your immune system is what protects you from bacterial and viral infections. It is made up of lymphoid tissue, circulating white blood cells, and proteins throughout the body. When your body is infected, the virus produced antigens (foreign toxins), and your immune system acts to counteract these by producing antibodies that destroy the harmful invaders.", :tags=>"regular_access_to_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How accurate are the tests?', :body => "Antibody test results for HIV are accurate more than 99.5% of the time. Once blood has been taken, an Elisa test is used to test for HIV antibodies. A positive test result is then confirmed with a Western blot test.", :tags=>"regular_access_to_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Its difficult to predict the precise nature of the issues may arise in your relationship', :body => "But its likely to have an impact on bigger themes that can be present in any relationship, especially when significant stressors are present", :tags=>"relationships", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Particular events such as receiving an HIV diagnosis', :body => "This can include feeling emotions such as anger, guilt, fear, sadness and loneliness", :tags=>"relationships", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can you contract HIV during dental procedures?', :body => "Dentists display certificates stating that they follow standard  procedures in cleaning their equipment. The chances of contracting HIV from your dentist are statistically insignificant.", :tags=>"relationships", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can you contract HIV from sharing razors with an infected person?', :body => "Razors can collect blood during their use, and passing that razor to another may infect that person if his or her skin is cut.", :tags=>"relationships", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What percentage of people in the United States have HIV or AIDS?', :body => "1/250 people in the U.S. has AIDS.", :tags=>"relationships", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How Do I Disclose My HIV Status to Someone Im Dating?', :body => "We tend to use the word normalization a lot these days when talking about HIV. It is meant to reflect the fact that people with HIV can now not only have a normal quality of life, they can plan for the future, have kids, and carry on healthy sexual relationships if given the proper therapy and a few precautionary safeguards.", :tags=>"dating", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is Online Dating an Option?', :body => "Sometimes the fear of disclosure is so great that people will naturally turn to online HIV dating sites like pozmingle.com or volttage.com, or serosort on anonymous hook up sites, where they can either list or infer their HIV status to other online users. But that, of course, has its own set of hazards and limitations.", :tags=>"dating", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How do I disclosure I am infected to HIV with my partner while dating?', :body => "Secondary disclosures are the How did you get it? questions that arise sometimes tactlessly during the course of an HIV disclosure. Be prepared to tell as much as you want to. Try not to be evasive, but remember that you are not obliged to divulge every shred of your sexual or personal history.", :tags=>"dating", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should I inform early about my infection to my partner early?', :body => "There is no fixed rule as to whether you should disclose on your second date, third date, or when you think your relationship is about to get physical. Trust is the issue here. Try to gauge if the person youre dating is someone with whom you can share a confidence. Does he or she share confidences about past dates or lovers a little too easily? Is your conversation all on the surface, or is he or she willing to open up to you in a way that engenders trust? Let your best judgment guide you.", :tags=>"dating", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What should be the reaction during dating?', :body => "Simply put, how do you think you will react if youre rejected? Conversely, how will you react if youre not? Both of these scenarios are important to consider when considering a disclosure. Feeling gratitude for being accepted (as opposed to, say, relief or happiness) can be just as problematic as being thrown into an emotional tailspin if youre not. Examine why you are feeling the emotions you do and, if needed, work through them with a friend or counselor.", :tags=>"dating", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What illnesses caused by germs in food and water do people with HIV commonly get?', :body => "Germs in food and water that can make someone with HIV ill include E.coli, Salmonella", :tags=>"minimizing-risk", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Your healthcare provider is the best source of information for questions and concerns', :body => "Related topics for patients, as well as selected articles written for healthcare professionals, are also available. Some of the most relevant are listed below", :tags=>"minimizing-risk", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why does my provider want you to order so many tests?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"minimizing-risk", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Does spermicide provide additional protection against HIV?', :body => "You should not use additional or separate applications of spermicide for HIV prevention during vaginal or anal sex. Women who use spermicidal cream or jelly for pregnancy prevention should also use a condom teat04  o protect against HIV and to provide better protection against pregnancy than spermicide along.", :tags=>"minimizing-risk", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How can people who inject drugs reduce their risk of HIV infection?', :body => "The risk of becoming infected with HIV from needles and syringes can be completely eliminated by not injecting drugs. Methadone maintenance is the most effective treatment program for heroin users. Studies have shown that heroin users who are in a methadone maintenance program are up to six times less likely to get HIV than users who are not in a program. Drug treatment programs are available throughout New York State. Check the Resources section for phone numbers to locate drug treatment programs.", :tags=>"minimizing-risk", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What if I only use drugs on the weekend?', :body => "Recreational or occasional drug use can be just as dangerous as an addictive pattern of behavior. In particular, excessive alcohol or stimulant (meth) use can be damaging even on an intermittent basis. These behaviors can be associated with immune system damage, lack of medication or treatment adherence, infection, organ damage, and overdose. Some of these effects can be seen even if a person only uses them on the weekends or when out ", :tags=>"starting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Dont think of the disclosure as a "bombshell" or something for which you have to apologize.', :body => "testing a candidate vaccine is a very long process as it is not easy to find control populations; (iv) the efficacy of a vaccine is very hard to determine as the control population has to be followed for decades ", :tags=>"starting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What do the changes (or lack of change) in these blood tests mean?', :body => "Blood test", :tags=>"starting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are similar trials being conducted elsewhere?', :body => "Yes. In 2006, Family Health International, with funding from the Bill & Melinda Gates Foundation, completed a similar trial of tenofovir for HIV prevention among young women in Ghana, Nigeria, and Cameroon. The study provided the first data showing PrEP with tenofovir to be both safe and acceptable for use by HIV negative women, but did not indicate if it was effective in preventing new infections.", :tags=>"starting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why are there so many different trials currently ongoing?', :body => "A PrEP regimen that is proven effective in reducing HIV transmission in one population may not necessarily work in other at risk populations. Because of this, CDC and other researchers are conducting trials in population groups representing multiple routes of HIV transmission, including heterosexuals, MSM, and IDUs. These trials will help inform the development of public health guidance for different populations.", :tags=>"starting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What safeguards are in place to ensure protection of the volunteers?', :body => "TTo ensure that trials remain on solid scientific and ethical foundations, all procedures and plans are reviewed and approved by scientific and ethical review committees at CDC (called institutional review boards, or IRBs), as well as by IRBs or equivalent ethical review bodies established by each host country and research site.", :tags=>"accessing_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why is there no vaccine against HIV/AIDS so far?', :body => "There are many reasons for this. Among the most important are: the virus mutates very rapidly, so using a part of the virus or an attenuated version of the virus to prime the immune system is not safe as the vaccine itself could mutate into the deadly version;  since the human immune system cannot clear the virus even after years of very low viral load, the vaccine will have to be prevent infection from even taking hold such vaccines are called sterilizing vaccines;", :tags=>"accessing_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Will trial participants increase their risk behavior when they begin taking daily pills?', :body => "Several critical steps are being taken to guard against this possibility. First, it is important to ensure that participants understand that trial participation may not protect them from HIV infection because they may receive a placebo, or they may receive the study drug, the efficacy of which remains unproven. This and other key aspects of the trial, including potential risks and benefits of participation, are explained to potential volunteers in depth in language they understand, prior to their enrollment. To ensure participants fully understand all aspects of their participation, all volunteers are required to pass a comprehension test prior to providing written informed consent.", :tags=>"accessing_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What other issues will the trials examine?', :body => "CDCs trials are also designed to address several issues that will be critical to the design of future studies, as well as HIV prevention and treatment programs.", :tags=>"accessing_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why study two different drugs?', :body => "Globally, more than 7,000 new HIV infections occur daily, and additional prevention approaches are urgently needed. A combination of studies of both tenofovir alone and tenofovir plus emtricitabine will allow us to move forward as quickly and effectively as possible in the search for new solutions.", :tags=>"accessing_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How much does treatment cost?', :body => "The economic problems for orphans are considerable because of the
    AIDS related deaths of family members and relatives. First line antiretroviral drugs currently cost $25 per child per month. If they develop resistance to these they need to take second line drugs which cost $200. At BaanGerda, we currently have 19 children who take second line drugs. We also have one child who does not need to take any medication.", :tags=>"cost", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can they go to school and hold jobs who are infected?', :body => "Children with HIV who receive proper care and the right medical treatment have the same potential as anyone else. All of our children attend a nearby school, and we hope they will continue their education afterwards. We will help them to find work and encourage them to build their own lives. Whatever happens, BaanGerda will always be their home should they need it.", :tags=>"cost", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How long can someone with HIV expect to live? ', :body => "Exactly how HIV will affect a persons life span is still unknown; however, since the introduction of effective treatments, there has been a decrease in HIV related illnesses and increased life expectancy. Some people have been living with the virus for over 20 years. If medications are taken correctly, they can help maintain a healthy life for many years. It is hoped that eventually a cure will be found. In that respect, we consider BaanGerda to have a certain time bridging function.", :tags=>"cost", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How is it treated?', :body => "here are many different drugs that are used to slow the damaging effects of HIV. Antiretroviral (ARV) drugs slow down the replication of the virus and the destruction of the immune system. However, they do not totally rid the body of the virus. There is no drug that can vaccinate you against HIV or cure HIV. Its also believed that living a healthy lifestyle and eating a balanced diet can help.", :tags=>"cost", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is cost effectiveness analysis?', :body => "The CE ratio is a fraction used to compare the relative costs and outcomes of two or more interventions", :tags=>"cost", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I tell from looking at a person if they have HIV?', :body => "Most of time, there is no way of telling if someone has HIV by looking at them. However, if an infected person is not cared for and becomes sick, they may look small and thin and have skin diseases or other illnesses.", :tags=>"selecting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What other issues will trials examine?', :body => "Understanding the potential impact of use of a daily preventive drug on HIV risk behaviors will be critical should any PrEP drug prove effective in reducing HIV transmission. One of the greatest risks, as efforts progress", :tags=>"selecting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'When did the current trials begin and how are they designed?', :body => "The Thailand trial of tenofovir began in 2005, and the Botswana trial of tenofovir plus emtricitabine began in early 2007. Both trials are randomized, doubleblind, placebo controlled trials. In each trial, all participants receive risk reduction counseling and other prevention services", :tags=>"selecting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What will happen to participants who become infected during the trial?', :body => "Despite optimal prevention counseling, some participants will become HIV infected during the trial. To ensure that infected participants are quickly referred to the best available medical and psychosocial services, they receive free rapid HIV testing at every visit. Participants who become infected will receive confirmatory testing for infection", :tags=>"selecting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Will health care be provided for any health problems related to the drug?', :body => "Yes. In all CDC sponsored trials, researchers are monitoring participants closely for drug related side effects. If any problems requiring treatment occur", :tags=>"selecting_medication", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are some of the most common symptoms of HIV?', :body => "Feeling tired all the time, Frequent fevers, Rapid weight loss without dieting", :tags=>"side_effects", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How long does it take for AIDS to develop?', :body => "There is no set time when HIV can become AIDS. Its important to talk to your doctor about your treatment options for HIV.", :tags=>"side_effects", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV also from mosquitoes?', :body => "No. It is no longer believed that you can get HIV from biting and bloodsucking insects like mosquitoes. Studies have shown no evidence that you can get HIV from mosquitoes or any other insects", :tags=>"side_effects", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is the maximum amount of time a person can live with HIV or AIDS?', :body => "Currently there are over 500 people in San Francisco who are long term survivors; they have lived with the virus for over 15 years. The average survival time after an AIDS diagnosis is 4 years.", :tags=>"side_effects", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How safe is blood supply in the Singapore?', :body => "According to the CDC, the blood supply in the Singapore is one of the worlds safest.", :tags=>"side_effects", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Will homeopathy or ayurvedic medicines work?', :body => "As far as we know there is no homeopathic or ayurvedic medicine that can destroy the virus effectively and completely. Some medicines, including ayurvedic can strengthened the immune system, thus reducing the severity of the infection and resulting opportunistic infections, however they cannot clear the system of all HIV as necessary for a cure. Many people are claiming to cure HIV using homeopathy or ayurvedic medicines, but so far all these claims are false. Unfortunately many people in desperation are going to these doctors and are being cheated of all their money.", :tags=>"starting_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why is there no cure for HIV/AIDS so far?', :body => " the host cell of HIV is a very important regulator of the immune system, so we cannot afford to indiscriminately destroy it; we have to design drugs that only destroy the infected cells. once HIV infects a host cell, it prevents the cell from displaying markers indicating that it is infected, thus making it hard for the immune system to tell whether a cell is infected or not", :tags=>"starting_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is HIV/AIDS hereditary?', :body => "NO. It is acquired through sex with an infected person or if the blood of an infected person enters the body of another person through cuts, punctures or by transfusion.", :tags=>"starting_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are the different stages of HIV infection?', :body => "HIV infections is broadly categorized into three stages  acute, chronic, and AIDS. Acute stage typically lasts for 3 6 months after infection. During this time the virus multiplies very rapidly while the immune system slowly develops its response. The viral load during this time is very high and the chances of transferring the virus to another person is therefore also high.", :tags=>"starting_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How accurate is the HIV test?', :body => "If guidelines for testing are followed, test results have greater than 98% accuracy.", :tags=>"starting_treatment", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Where can I get tested for HIV?', :body => "Many places provide testing for HIV, such as doctors offices, local health departments, hospitals, or locations set up specifically for HIV testing.n", :tags=>"clinics", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from body piercing or getting a tattoo?', :body => "You can get HIV from body piercing or getting a tattoo if the tools have infected blood on them and have not been sterilized or disinfected. The Centers for Disease Control and Prevention recommends thorough cleaning and sterilization of tools that penetrate skin, including those used during body piercing and tattooing. Or they should be used once and thrown away. If you are thinking about getting a tattoo or a body piercing, be sure to ask the staff about what they do to prevent spreading HIV.", :tags=>"clinics", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are the different ways of acquiring this infection?', :body => "In infected people, the virus is present mainly in the blood, and in the seminal fluids of man and vaginal secretions and breast milk of women. To transmit it from one person to another requires either the blood of an infected person enter into the body of another, or through sex, or from mother to child.", :tags=>"clinics", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is the difference between testing HIV positive and having AIDS?', :body => "A positive test means only that the body has begun to produce antibodies to the virus. AIDS and the opportunistic infections which accompany it develop after the virus sufficiently weakens the bodys immune system.", :tags=>"clinics", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are the initial symptoms of HIV infection?', :body => "The first period of HIV infection is called the acute stage, and it typically lasts for 3 6 months after infection. During this time the virus multiplies very rapidly while the immune system slowly develops its response. During this time the manifestations of the infection are typical of viral infections like influenza or mononucleosis and often accompanied by a rash. The symptoms include headache, loss of energy, fever, chills and possibly diarrhea. The typical duration of the symptoms is about a week, after which the person recovers.", :tags=>"clinics", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are T cells? Why are T cells important in HIV?', :body => "T cells, or CD4+ cells, are a kind of white blood cell and are an important part of the immune system. When HIV infects the body, it attacks these cells, reducing their count as the virus multiplies. Fewer T cells means a weakened immune system.", :tags=>"doctors", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is a viral load test?', :body => "A viral load test measures how much HIV is in a sample of your blood", :tags=>"doctors", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'When should I start HIV treatment?', :body => "Talk to your healthcare provider about when to start HIV treatment. You and your healthcare provider can decide when you should begin taking medications to treat your HIV.", :tags=>"doctors", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is ART?', :body => "ART stands for AntiRetroviral Therapy. It is a combination HIV therapy that contains at least three drugs from at least two classes.", :tags=>"doctors", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Potential limitations of earlier initiation of treatment?', :body => "Risks of side effects and possible problems related to HIV medications", :tags=>"doctors", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Lifting HIV related travel restrictions', :body => "The International Task Team on HIV Related Travel Restrictions has pointed out that HIV related travel restrictions raise serious human rights concerns", :tags=>"travel", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is my diagnosis? What does this mean?', :body => "ART combinations are effective because they slow HIV from multiplying at different stages in the process.", :tags=>"travel", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can you contract HIV from sharing razors with an infected person? I am affraid', :body => "Razors can collect blood during their use, and passing that razor to another may infect that person if his or her skin is cut.", :tags=>"travel", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How safe is it to donate or to receive blood?', :body => "It is safe to donate blood since a new kit is used each time. Receiving blood is statistically safe.", :tags=>"travel", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are the symptoms of HIV infection during the chronic phase?', :body => "The chronic phase can last anywhere from few months to fifteen years in persons who are not on anti retroviral therapy. The duration of this phase depends on the severity of the infection, the type of infection (for example HIV 1 clade), the persons immune response, their general health and access to health care. As the infection progresses, the person takes longer and longer to recover from diseases like influenza and diarrhea.", :tags=>"travel", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is it necessary for the HIV infected persons to die in 10 years ?', :body => "NO. Ten years is usually the average time that people in the USA lived for after HIV infection and in days before the discovery and availability of anti retroviral drugs. There are many people who are now taking these medicines and have survived fifteen or more years and are still very healthy", :tags=>"migration", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How accurate is the HIV test? Where are the tests done secretely?', :body => "If guidelines for testing are followed, test results have greater than 98% accuracy.", :tags=>"migration", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why did HIV not originate earlier in human history?', :body => "As explained in a question above, the emergence of HIV required two accidents. First was the introduction of SIVcpz into humans, and the second was its mutation to HIV. This is a rare event but it could have happened earlier. Furthermore, to spread, the infected person has to be able to pass HIV on to several other people, and they to others creating large chains. It seems that this combination of all three conditions occurred only recently.", :tags=>"migration", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How effective is AZT in fighting HIV?', :body => "AZT has been shown to impede the progression of the virus in some individuals for a limited period of time", :tags=>"migration", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How does the penalty framework work?', :body => "Exactly how HIV will affect a persons life span is still unknown; however, since the introduction of effective treatments, there has been a decrease in HIV related illnesses and increased life expectancy. Some people have been living with the virus for over 20 years. If medications are taken correctly, they can help maintain a healthy life for many years. It is hoped that eventually a cure will be found. In that respect, we consider", :tags=>"migration", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from casual contact like hugging and shaking hands?', :body => "No. HIV is not transmitted through day to day contact in the workplace, schools, or social settings. HIV is not spread through casual contact such as shaking hands, hugging, or casual kissing.", :tags=>"tourism", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How might I get HIV? What are the precations?', :body => "By sharing drug needles or syringes with someone who has HIV, Mothers who have HIV can pass the virus to their babies during pregnancy, birth or breastfeeding after birth", :tags=>"tourism", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'RESTRICTIONS ON TRAVELING WITH HIV/AIDS', :body => "Some countries restrict visitors who are HIV positive from entering their borders or staying for long periods of time. ", :tags=>"tourism", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'BRINGING MEDICATIONS OR FILLING PRESCRIPTIONS ABROAD', :body => " including the generic names of prescribed drugs. Any medications being carried overseas should be left in their original containers and be clearly labeled", :tags=>"tourism", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is the safest mode during travel?', :body => "Carry a letter from a clinician, Rebottle medications with non prescription packaging", :tags=>"tourism", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What are high risk groups?', :body => "High risk groups are people who due to their lifestyle or occupation, are at very high risk for acquiring HIV infection. These include sex workers (both male, female, and transgender prostitutes), intravenus drug users, men who have sex with men, and people who have sex with many different partners whose sexual history and HIV status they do not know.", :tags=>"well_being", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are you being honest with yourself about what you want? Inform me!', :body => "Most of time, there is no way of telling if someone has HIV by looking at them. However, if an infected person is not cared for and becomes sick, they may look small and thin and have skin diseases or other illnesses", :tags=>"well_being", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How long can a person survive after developing AIDS?', :body => "The exact time between the onset of AIDS and death depends on the individual and ranges from a few weeks to a couple of years. To a large extend this time depends on whether the person has access to treatment for opportunistic infections and can afford the anti retroviral drugs to control the underlying HIV infection", :tags=>"well_being", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Will I have to file or amend my old tax returns? I am ready', :body => "Reiterate your boundaries if need be. And, be ready to exit the relationship to save his/her feelings and avoid any potential drama.", :tags=>"well_being", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should you tell you friend that you are not in love with her?', :body => "Yes. In all CDC sponsored trials, researchers are monitoring participants closely for drug related side effects. If any problems requiring treatment occur", :tags=>"well_being", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How will you know if youve had a successful life?', :body => "If a violence prone husband becomes agitated and abusive, the wife should remove herself from danger, by leaving the home if necessary.", :tags=>"fitness", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How long can a person survive after being infected by HIV?', :body => "The usual life time is about 10 years. The exact life expectancy varies from person to person and without anti retroviral treatment it can be anywhere from between 2 15 years.", :tags=>"fitness", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How would will your friends describe you?', :body => "It depends on the guy, of course, but in general it means that he wants to be as intimate with you as possible", :tags=>"fitness", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can they go to school and hold jobs?', :body => "At the start of every intravenous injection, blood is introduced into needles and syringes. HIV can be found in the blood of a person infected with the virus. The reuse of a blood contaminated needle or syringe by another drug injector sometimes called direct syringe sharing carries a high risk of HIV transmission because infected blood can be injected directly into the bloodstream.", :tags=>"fitness", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should my baby get the same vaccines (needles) as other babies?', :body => "You may not TOTALLY be in a place where you believe in yourself, but you must have some strong feelings of self worth before beginning a no strings attached relationship..sdgjkn", :tags=>"fitness", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV be transmitted through an insect bite?', :body => "No, Insects can NOT transmit HIV. Research has shown that HIV does not replicate or survive well in insects", :tags=>"nutrition", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What if I only use drugs on the weekend? Is that really that bad?', :body => "There is no set time when HIV can become AIDS. Its important to talk to your doctor about your treatment options for HIV", :tags=>"nutrition", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What illnesses caused by germs with HIV commonly get? What are the precations?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"nutrition", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Is there a place I can go learn more about HIV terms? ', :body => "Do you think its a good idea for them to look up their birth parents", :tags=>"nutrition", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What is cost effectiveness analysis? Where shall be the less cost?', :body => "No. HIV is not like the flu or a cold. It is not passed through casual contact or by being near a person who is infected.", :tags=>"nutrition", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How might I get HIV?', :body => "By sharing drug needles or syringes with someone who has HIV", :tags=>"work", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Are you prepared to be honest with your sex partner? How did you get it?', :body => "Reiterate your boundaries if need be. And, be ready to exit the relationship to save his/her feelings and avoid any potential drama", :tags=>"work", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What should a Christian wife do if her husband fails to be the authority for her to submit to?', :body => "happens frequently, and especially in the realm of spiritual authority.", :tags=>"work", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'If the woman is to submit, isnt she playing a lesser role condition?', :body => "Every member of the family  not just the wife  comes under the command to submit", :tags=>"work", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'While the short term effects of HIV and the medications', :body => "Do you have good friends who practice religions that are different from ours", :tags=>"work", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Should HIV Positives to be given care?', :body => "HIV positives are advised to take enough medication to cover delays.", :tags=>"health_checks", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What was your biggest worry about having a child while being HIV positive?', :body => "You know, it can be hard to find out if hes telling the truth or not.", :tags=>"health_checks", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What will happen to participants who do become infected during the trial?', :body => "There is not sufficient viral load, and the mosquitos blood is not compatible with the virus.", :tags=>"health_checks", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What information must be given to a person before an HIV test is given?', :body => "They possess everything you desire in a mate. If you want someone with a good job", :tags=>"health_checks", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What type of therapy or medications will I receive?', :body => "When someone takes out a life insurance policy they will pay a regular premium, usually monthly. How much this is depends on several factors including how much cover they want", :tags=>"health_checks", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Life insurance policies taken out before an HIV positive diagnosis', :body => "Some people will have taken out a life insurance policy at a time before they tested positive for HIV. In this situation, it is not necessary to inform the insurer that their health status has changed and, even if they do, the insurers cannot change the policy nor increase the premiums.", :tags=>"health_insurance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can I get HIV from mosquitoes?', :body => "No, there is not sufficient viral load and the chlorine will kill the virus.", :tags=>"health_insurance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'If the woman is to submit, isnt she playing a lesser role than man?', :body => "If a violence prone husband becomes agitated and abusive, the wife should remove herself from danger, by leaving the home if necessary.", :tags=>"health_insurance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How does HIV attack the immune system?', :body => "Has any one done this already? Any step by step to not forget anything?", :tags=>"health_insurance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'What flirty questions should you ask your crush?', :body => "It depends on the guy, of course, but in general it means that he wants to be as intimate with you as possible", :tags=>"health_insurance", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How safe is the blood supply in the Singapore?', :body => "because levels of HIV in the blood and semen or vaginal secretions are poorly correlated", :tags=>"inclusion_&_iscrimination", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV be only transmitted through an insect bite?', :body => "No, Insects can NOT transmit HIV. Research has shown that HIV does not replicate or survive well in insects", :tags=>"inclusion_&_iscrimination", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How should the informed consent only to provide scientific information that could treatments?', :body => "According to the CDC, the blood supply in the Singapore is one of the worlds safest", :tags=>"inclusion_&_iscrimination", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why does my provider want to order provided so many tests?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"inclusion_&_iscrimination", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'my doctor says i have thrush but not HIV being', :body => "activities may include sleeping through the night, daily hygiene, driving", :tags=>"inclusion_&_iscrimination", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How safe is the blood supply in the Singapore?', :body => "because levels of HIV in the blood and semen or vaginal secretions are poorly correlated", :tags=>"safer_sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Can HIV be only transmitted through an insect bite?', :body => "No, Insects can NOT transmit HIV. Research has shown that HIV does not replicate or survive well in insects", :tags=>"safer_sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'How should the informed consent only to provide scientific information that could treatments?', :body => "According to the CDC, the blood supply in the Singapore is one of the worlds safest", :tags=>"safer_sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'Why does my provider want to order provided so many tests?', :body => "Its important to remember that your provider will be treating your HIV but also needs to consider your overall health and well being", :tags=>"safer_sex", :group_id=>Group.first.id)
    User.first.questions.create!(:title => 'my doctor says i have thrush but not HIV being', :body => "activities may include sleeping through the night, daily hygiene, driving", :tags=>"safer_sex", :group_id=>Group.first.id)

  end


  desc "To update Default tags Questions Answers"
  task :updateTagsQusAns => :environment do
    # default tags
    # to delete all the answers
    Answer.delete_all
    @tags= Group.last.default_tags
    @user = User.first
    @group = Group.first
    @question = Question.all.map(& :id)
    @question.each do |question|
      # dummy answers
      if Question.find(question).answers.count.equal? 0
        questags = Question.find(question).tags
        body = "#{Question.where(:_id=>question).first.tags} Answer Lorem Ipsum  simply dummy text "
        answerHash = {tags: questags, group_id: @group.id, body: body, question_id: question}
        @user.answers.create!(answerHash)
        puts "Answers created"
      end
    end
    # loop end here
  end
  desc "To update UserTagQuestions"
  task :updateUserTagQuestions => :environment do
    @usertags = Tag.all
    @user = User.first
    @group = Group.first
    @usertags.each do |tag|
     if Question.any_in(:tags=>[tag.name.to_s]).count.equal? 0
        question = "#{tag.name } First question Lorem Ipsum" 
        question1 = "#{tag.name } Second questions All the Lorem Ipsum" 
        body = "#{tag.name } First body the Lorem Ipsum" 
        body1 = "#{tag.name } second body Lorem Ipsum " 
        questionHash = {title: question, tags: tag.name.to_s, group_id: @group.id, body: body}
        questionHash1 = {title: question1, tags: tag.name.to_s, group_id: @group.id, body: body1}
        @user.questions.create!(questionHash)
        @user.questions.create!(questionHash1)
        puts "User tags question created "
      end
    end
  end
  desc "To update Comments"
    task :addCommentsToQuestions => :environment do
      @users = User.all.map(& :id)
      @questions = Question.all
      - i=0
      @questions.each do |question|
        question.comments.create!(:body=>"Hello first new comment  by #{User.where(:_id=>@users[i]).first.name}. ",:user_id=>"#{@users[i]}")
        question.comments.create!(:body=>"Hello second new comment  by #{User.where(:_id=>@users[i]).first.name}.",:user_id=>"#{@users[i]}")
        puts "comments created "
        -i = i+=1
          if (i == ((@users.count)-1))
            i=0
          end
      end
    end
  desc "New Comments to Badges "
  task :addCommentsToBadges => :environment do
    @users = User.all
    @users.each do |user|
      BadgeComment.create!(:message=>"Commented by #{user.name}",:user_id=>user.id)
      puts "New commet crated to badges"
    end
    # BadgeComment.last(4).each do |badge|
    #   badge.ancestry = BadgeComment.first.id.to_s
    # end
  end
  desc "To update Routes"
    task :addRoutes => :environment do
      Route.delete_all
      path =['questions','answers','tags','badges','services-map','services-map/singapore','services-map/india','services-map/malaysia',
        'about','contact','terms','privacy-policy','polls','survey','tags/disclosure','tags/casual_partners',
        'tags/family','tags/friends','tags/regular_partners','tags/drugs','tags/partying','tas/sex','tags/first_diagnosis','tags/situation',
        'tags/maintaining_treatment','tags/comments','tags/regular_access_to_medication','tags/relationships','tags/dating','tags/sex','tags/minimising-risk',
        'tags/safer_sex','tags/starting_medication','tags/accessing_medication','tags/selecting_medication','tags/cost','tags/side_effects',
        'tags/starting_treatment','tags/clinics','tags/doctors','tags/travel','tags/migration','tags/tourism','tags/well_being',
        'tags/fitness','tags/nutrition','tags/work','tags/health_insurance','tags/health_checks']
        path.each do |i|
          Route.create!(url: "#{i}")
          puts "Routes created"
        end
    end
end

  end


  desc "To update Default tags Questions Answers"
  task :updateTagsQusAns => :environment do
    # default tags
    # to delete all the answers
    Answer.delete_all
    @tags= Group.last.default_tags
    @user = User.first
    @group = Group.first
    @question = Question.all.map(& :id)
    @question.each do |question|
      # dummy answers
      if Question.find(question).answers.count.equal? 0
        questags = Question.find(question).tags
        body = "#{Question.where(:_id=>question).first.tags} Answer Lorem Ipsum  simply dummy text "
        answerHash = {tags: questags, group_id: @group.id, body: body, question_id: question}
        @user.answers.create!(answerHash)
        puts "Answers created"
      end
    end
    # loop end here
  end
  desc "To update UserTagQuestions"
  task :updateUserTagQuestions => :environment do
    @usertags = Tag.all
    @user = User.first
    @group = Group.first
    @usertags.each do |tag|
     if Question.any_in(:tags=>[tag.name.to_s]).count.equal? 0
        question = "#{tag.name } First question Lorem Ipsum" 
        question1 = "#{tag.name } Second questions All the Lorem Ipsum" 
        body = "#{tag.name } First body the Lorem Ipsum" 
        body1 = "#{tag.name } second body Lorem Ipsum " 
        questionHash = {title: question, tags: tag.name.to_s, group_id: @group.id, body: body}
        questionHash1 = {title: question1, tags: tag.name.to_s, group_id: @group.id, body: body1}
        @user.questions.create!(questionHash)
        @user.questions.create!(questionHash1)
        puts "User tags question created "
      end
    end
  end
  desc "To update Comments"
    task :addCommentsToQuestions => :environment do
      @users = User.all.map(& :id)
      @questions = Question.all
      - i=0
      @questions.each do |question|
        question.comments.create!(:body=>"Hello first new comment  by #{User.where(:_id=>@users[i]).first.name}. ",:user_id=>"#{@users[i]}")
        question.comments.create!(:body=>"Hello second new comment  by #{User.where(:_id=>@users[i]).first.name}.",:user_id=>"#{@users[i]}")
        puts "comments created "
        -i = i+=1
          if (i == ((@users.count)-1))
            i=0
          end
      end
    end
  desc "New Comments to Badges "
  task :addCommentsToBadges => :environment do
    @users = User.all
    @users.each do |user|
      BadgeComment.create!(:message=>"Commented by #{user.name}",:user_id=>user.id)
      puts "New commet crated to badges"
    end
    # BadgeComment.last(4).each do |badge|
    #   badge.ancestry = BadgeComment.first.id.to_s
    # end
  end
  desc "To update Routes"
    task :addRoutes => :environment do
      Route.delete_all
      path =['questions','answers','tags','badges','services-map','services-map/singapore','services-map/india','services-map/malaysia',
        'about','contact','terms','privacy-policy','polls','survey','tags/disclosure','tags/casual_partners',
        'tags/family','tags/friends','tags/regular_partners','tags/drugs','tags/partying','tas/sex','tags/first_diagnosis','tags/situation',
        'tags/maintaining_treatment','tags/comments','tags/regular_access_to_medication','tags/relationships','tags/dating','tags/sex','tags/minimising-risk',
        'tags/safer_sex','tags/starting_medication','tags/accessing_medication','tags/selecting_medication','tags/cost','tags/side_effects',
        'tags/starting_treatment','tags/clinics','tags/doctors','tags/travel','tags/migration','tags/tourism','tags/well_being',
        'tags/fitness','tags/nutrition','tags/work','tags/health_insurance','tags/health_checks']
        path.each do |i|
          Route.create!(url: "#{i}")
          puts "Routes created"
        end
    end
end