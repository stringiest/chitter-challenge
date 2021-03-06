require 'peep'
require 'database_helpers'

describe Peep do
  describe '.all' do
    it 'returns all peeps' do
      @time_now = Time.new(2020, 12, 01)
      allow(Time).to receive(:now).and_return(@time_now)
      peep = Peep.create(script: 'This is my first peep', created_at: Time.now)
      Peep.create(script: 'Why have you used my identity?', created_at: Time.now)

      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps.first).to be_a Peep
      expect(peeps.first.created_at).to eq @time_now
      expect(peeps.first.peep_id).to eq peep.peep_id
      expect(peeps.first.script).to eq 'This is my first peep'
      expect(peeps.last.script).to include 'Why have you used my identity?'
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      @time_now = Time.new(2020, 12, 01)
      allow(Time).to receive(:now).and_return(@time_now)
      peep = Peep.create(script: 'I love Sundays!', created_at: Time.now)
      persisted_data = persisted_data(peep_id: peep.peep_id)

      expect(peep).to be_a Peep
      expect(peep.peep_id).to eq persisted_data['peep_id']
      expect(peep.script).to eq 'I love Sundays!'
      expect(peep.created_at).to eq @time_now

    end
  end
end
