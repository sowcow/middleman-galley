Given 'I prepare following files:' do |table|
  files = table.raw
  files.each { |file|
    file = file[0]
    step "an empty file named \"#{file}\""
  }
end

And /^the file "(.*?)" has links to:$/ do |file, table|
  links = table.raw.map &:first

  #require 'nokogiri'
  #doc = in_current_dir { Nokogiri.HTML File.read file }
  #doc.css('a').map { |a| a[:href] }.should == files
  links.each { |link|
    text = 'hello'
    step %'the file "#{file}" should contain "#{text}"'
  }
end
