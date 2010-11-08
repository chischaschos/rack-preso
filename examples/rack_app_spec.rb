test_app = lambda do |env|
  [200, {'Content-type' => 'text/html'}, ['Yes']]
end

describe test_app, 'RackApp' do

  it { should respond_to(:call) }
  
  context '#call' do

    let(:response) { subject.call({}) }
    it do
      response.should be_an(Array)
      response.should have_exactly(3).items
    end

    context 'response http status' do

      let(:http_status) { response[0].to_i }
      it do
         http_status.should be_an(Integer)
         http_status.should > 100
      end

    end

    context 'response http headers' do

      let(:http_header) { response[1] }
      it do
        http_header.should respond_to(:each)
        http_header.each do |element|
          element.should be_a(Hash) 

          element.key.should be_a(String)
          element.key.should_not eq('Status')
          element.key.should_not =~ /[:\n]+[-_]*$/
          element.key.should =~ /^[a-zA-Z]{1}[\w-]/

          element.value.should be_a(String)
          element.value.
        end
      end

    end

    context 'response http body' do
  
      it { response[1].should be_a(Hash) }
  
    end

  end

end

