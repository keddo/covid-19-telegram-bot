require './lib/api_request'
require './lib/bot.rb'
require './lib/config.rb'
describe ApiRequest do
  let (:res) { {"cases": 0, "todayCases": 0, "deaths": 0,"recovered": 0,"todayRecovered": 0,"active": 0,
    "critical": 0,
  }}
  describe '#global_status' do
    it 'Test if it returns Hash' do
      expect((ApiRequest.global_status).is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
  end

  describe '#status_by_country' do
    it 'Test if the expected value is Hash' do
        expect((ApiRequest.status_by_country('Ethiopia')).is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
  end

  describe '#status_by_continent' do
    it 'Test if the array contains expected value' do
        expect((ApiRequest.status_by_continent('Africa')).is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
  end
  describe '#top_cases' do
    it 'Test if it returns a string value' do
      expect((ApiRequest.top_cases(5).is_a?(String))).to eql(true)
    end
  end
  describe '#historical' do
    it 'Test if it returns a string value' do
      expect(ApiRequest.historical('5', 'Ethiopia').is_a?(String)).to eql(true)
    end
  end
  describe '#print_global_status' do
    it 'Test if the is a string' do
      expect((ApiRequest.print_global_status(res)).kind_of? String).to eql(true)
    end
  end
  describe '#print_country_status' do
    it 'Test if the is a string' do
        expect((ApiRequest.print_country_status(res)).kind_of? String).to eql(true)
    end
  end
  describe '#print_history' do
    it 'Test if the is a string' do
        expect((ApiRequest.print_country_status(res)).kind_of? String).to eql(true)
    end
  end
  describe '#instroduction' do
    it 'Test if the is a string' do
        expect((ApiRequest.instroduction).kind_of? String).to eql(true)
    end
  end
  describe '#print_top_cases' do
    it 'Test if the is a string' do
        expect((ApiRequest.print_top_cases("Ethiopia", 12324, 1)).kind_of? String).to eql(true)
    end
  end
  describe '#help' do
    it 'Test if the is a string' do
        expect((ApiRequest.help).kind_of? String).to eql(true)
    end
  end
  describe '#json_response' do
    it 'Test if the array contains expected value' do
      expect(ApiRequest.json_response(GLOBAL_URL).is_a?(Hash)).to eql(true)
    end
  end
end

