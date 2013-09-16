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
        question = "Lorem Ipsum simply dummy text for printing and typesetting questions".split("").shuffle.join
        question1 = "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary".split("").shuffle.join
        body = "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text.".split("").shuffle.join
        body1 = "Lorem Ipsum  simply dummy text for body of the second question".split("").shuffle.join
        questionHash = {title: question, tags: tag[0].to_s, group_id: @group.id, body: body}
        questionHash1 = {title: question1, tags: tag[0].to_s, group_id: @group.id, body: body1}
        @user.questions.create!(questionHash)
        @user.questions.create!(questionHash1)
        puts "Question created main tag"
      end
      unless tag[1].nil?
        tag[1].each do |subtag|
          if Question.any_in(:tags=>[subtag.to_s]).count.equal? 0
            question = "Lorem Ipsum simply dummy text for printing and typesetting questions".split("").shuffle.join
            question1 = "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary".split("").shuffle.join
            body = "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text.".split("").shuffle.join
            body1 = "Lorem Ipsum  simply dummy text for body of the second question".split("").shuffle.join
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
        body = "Lorem Ipsum  simply dummy text for body of the questionAnswers".split("").shuffle.join
        answerHash = {tags: questags, group_id: @group.id, body: body, question_id: question}
        @user.answers.create!(answerHash)
        puts "Answers created"
      end
      # conditional statement ends here
          # unless tag[1].nil?
          #   tag[1].each do |subtag|
          #     if Question.find(@question[i+=1]).answers.count.equal? 0
          #       questags = Question.find(@question[i+=1]).tags
          #       body = "Lorem Ipsum  simply dummy text for body of the questionAnswers".split("").shuffle.join
          #       answerHash = {tags: questags, group_id: @group.id, body: body,question_id: @question[i+1]}
          #       @user.answers.create!(answerHash)
          #       puts "Answers created for subtag"
          #     end
          #   end
          # end
          # conditional statement ends here
    end
    # loop end here
  end
end