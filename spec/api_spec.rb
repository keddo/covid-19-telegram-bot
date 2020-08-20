require_relative './lib/api_request.rb'
require_relative './lib/config.rb'
describe ApiRequest do
  let (:res) {
    { "cases": 0,
      "todayCases": 0,
      "deaths": 0,
      "recovered": 0,
      "todayRecovered": 0,
      "active": 0,
      "critical": 0 }
  }
  let (:api) { ApiRequest.new }
  describe '#global_status' do
    it 'Test if it returns Hash' do
      expect(api.global_status.is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
    it 'Test if returns hush' do
      expect(api.global_status.is_a?(Hash)).not_to eql(({}).is_a?(Array))
    end
  end

  describe '#status_by_country' do
    it 'Test if the expected value is Hash' do
      expect(api.status_by_country('Ethiopia').is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
    it 'Test if the expected value is Hash' do
      expect(api.status_by_country('Ethiopia').is_a?(Hash)).not_to eql(({}).is_a?(Array))
    end
  end
  describe '#status_by_continent' do
    it 'Test if the array contains expected value' do
      expect(api.status_by_continent('Africa').is_a?(Hash)).to eql(({}).is_a?(Hash))
    end
    it 'Test if the array contains expected value' do
      expect(api.status_by_continent('Africa').is_a?(Hash)).not_to eql(({}).is_a?(Array))
    end
  end
  describe '#top_cases' do
    it 'Test if it returns a string value' do
      expect(api.top_cases(5).is_a?(String)).to eql(true)
    end
    it 'Test if it returns a string value' do
      expect(api.top_cases(5).is_a?(String)).not_to eql(false)
    end
  end
  describe '#historical' do
    it 'Test if it returns a string value' do
      expect(api.historical('5', 'Ethiopia').is_a? String).to eql(true)
    end
    it 'Test if it returns a string value' do
      expect(api.historical('5', 'Ethiopia').is_a? String).not_to eql(false)
    end
  end
  describe '#print_global_status' do
    it 'Test if the is a string' do
      expect(api.print_global_status(res).is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.print_global_status(res).is_a? String).not_to eql(false)
    end
  end
  describe '#print_country_status' do
    it 'Test if the is a string' do
      expect(api.print_country_status(res).is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.print_country_status(res).is_a? String).not_to eql(false)
    end
  end
  describe '#print_history' do
    it 'Test if the is a string' do
      expect(api.print_country_status(res).is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.print_country_status(res).is_a? String).not_to eql(false)
    end
  end
  describe '#instroduction' do
    it 'Test if the is a string' do
      expect(api.instroduction.is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.instroduction.is_a? String).not_to eql(false)
    end
  end
  describe '#print_top_cases' do
    it 'Test if the is a string' do
      expect(api.print_top_cases('Ethiopia', 12_324, 1).is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.print_top_cases('Ethiopia', 12_324, 1).is_a? String).not_to eql(false)
    end
  end
  describe '#help' do
    it 'Test if the is a string' do
      expect(api.help.is_a? String).to eql(true)
    end
    it 'Test if the is a string' do
      expect(api.help.is_a? String).not_to eql(false)
    end
  end
end
