atom_feed do |feed|
  feed.title("service_providers feed")
  

  #tags = params[:tags]
  #if tags && !tags.empty?
   # title += " tags: #{tags.kind_of?(String) ? tags : tags.join(", ")}"
  #end

  #if @langs_conds
  #  if @langs_conds.kind_of?(Array)
  #    title += " languages: #{@langs_conds.join(", ")}"
  #  else
  #    title += " languages: #{@langs_conds}"
  #  end
  #end
  for service_provider in @service_providers
    next if service_provider.nil? #|| service_provider.updated_at.blank?
    #feed.updated(service_provider)
    feed.entry(service_provider, :url => service_provider_url(service_provider)) do |entry|
      entry.title(service_provider.name)
      entry.content(truncate("#{markdown(service_provider.description)}",length: 50), :type => 'html')
      
      #entry.author do |author|
      #author.name(h(service_provider)
      #end
    end
  end
end