atom_feed do |feed|

  feed.title("Comments RSS")
  feed.updated(@question_comments_feed[0].updated_at) if @question_comments_feed.length > 0

  @question_comments_feed.each do |comment|
    feed.entry(comment,:url=> root_url) do |entry|
      entry.title(comment.body)
     
      entry.url
    end
  end
end
