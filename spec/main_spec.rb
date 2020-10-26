require '../manipulate_string.rb'

RSpec.describe ManipulateString do
  it 'puts out correct results' do
    tests = [
      {input: {string: 'Hello World', command: 'hhlhllhlhhll'}, output: {result: 'Hello World', cursor: 2}},
      {input: {string: 'Hello World', command: 'rhllllllrw'},   output: {result: 'hello world', cursor: 6}},
      {input: {string: 'Hello World', command: 'rh6l9l4hrw'},   output: {result: 'hello world', cursor: 6}},
      {input: {string: 'Hello World', command: '9lrL7h2rL'},    output: {result: 'HeLLo WorLd', cursor: 3}},
      {input: {string: 'Hello World', command: '999rs'},        output: {result: 'sssssssssss', cursor: 10}}
    ]
    tests.each do |test|
      input = test[:input][:string]
      command = test[:input][:command]
      expect(ManipulateString.new(input, command).run).to eq(test[:output])
    end
  end

  it 'validates wrong results' do
    tests = [
      {input: {string: 'Hello World', command: 'hhlhllhlhhll'}, output: {result: 'ello World', cursor: 3}},
      {input: {string: 'Hello World', command: 'rhllllllrw'},   output: {result: 'ello world', cursor: 7}},
      {input: {string: 'Hello World', command: 'rh6l9l4hrw'},   output: {result: 'ello world', cursor: 2}},
      {input: {string: 'Hello World', command: '9lrL7h2rL'},    output: {result: 'eLLo WorLd', cursor: 1}},
      {input: {string: 'Hello World', command: '999rs'},        output: {result: 'ssssssssss', cursor: 9}}
    ]
    tests.each do |test|
      input = test[:input][:string]
      command = test[:input][:command]
      expect(ManipulateString.new(input, command).run).to_not eq(test[:output])
    end
  end
end
