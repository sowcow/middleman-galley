Given 'I prepare following files:' do |table|
  files = table.raw
  files.each { |file|
    file = file[0]
    step "an empty file named \"#{file}\""
  }
end
