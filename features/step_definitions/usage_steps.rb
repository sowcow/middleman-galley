require 'nokogiri'
  
#Given 'I prepare following files:' do |table|
#  files = table.raw
#  files.each { |file|
#    file = file[0]
#    step "an empty file named \"#{file}\""
#  }
#end

And /^the file "(.*?)" has links:$/ do |file, table|
  names, links = table.raw.transpose
  assert_links file, names, links
end

And /^the file "(.*?)" has no links$/ do |file|
  assert_links file, [], []
end

def parse_html file
  in_current_dir { Nokogiri.HTML File.read file }
end
def assert_links file, names, links
  doc = parse_html file
  doc.css('a').map { |a| a[:href] }.should == links
  doc.css('a').map { |a| a.text }.should == names
end
def assert_images file, images
  doc = parse_html file
  doc.css('img').map { |a| a[:src] }.should == images
end

And /^the file "(.*?)" has images:$/ do |file, table|
  assert_images file, table.raw.map(&:first)
end
And /^the file "(.*?)" has no images$/ do |file|
  assert_images file, []
end

And /^document "(.*?)" has (\d+) "(.*?)"$/ do \
  |file, count, selector|
  count = count.to_i
  select(file, selector).count.should == count
end

def select file, selector
  parse_html(file).css selector
end
