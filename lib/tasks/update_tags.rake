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
    Question.delete_all
    @tags= Group.last.default_tags
    @user = User.first
    @group = Group.first
    @tags.each do |tag|
      # dummy question
      # if tag.include?(params[:type])
      #   @tag_data << tag[0]
      # end
      if Question.any_in(:tags=>[tag[0].to_s]).count.equal? 0
        question = "#{tag[0].to_s} First question Lorem Ipsum "
        question1 = "#{tag[0].to_s} Second questions All the Lorem Ipsum" 
        body = "#{tag[0].to_s} First body the Lorem Ipsum" 
        body1 = "#{tag[0].to_s} second body Lorem Ipsum " 
        questionHash = {title: question, tags: tag[0].to_s, group_id: @group.id, body: body}
        questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
        @user.questions.create!(questionHash)
        @user.questions.create!(questionHash1)
        puts "Question created main tag"
      end
      unless tag[1].nil?
        tag[1].each do |subtag|
          if Question.any_in(:tags=>[subtag.to_s]).count.equal? 0
            question = "#{subtag.to_s} First question Lorem Ipsum" 
            question1 = "#{subtag.to_s} Second questions All the Lorem Ipsum" 
            body = "#{subtag.to_s} First body the Lorem Ipsum"
            body1 = "#{subtag.to_s} second body Lorem Ipsum " 
            questionHash = {title: question, tags: [subtag.to_s], group_id: @group.id,body: body}
            questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
            @user.questions.create!(questionHash)
            @user.questions.create!(questionHash1)
            puts "Question created for subtag"
          end
        end
      end
      # conditional statement ends here
    end
    # loop ends here
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