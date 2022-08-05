require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  context '' do
    let(:lead) do
      lead = OpenStruct.new
      lead.source = source
      lead.description = 'Loja: SHARK'

      lead
    end

    let(:source) do
      source = OpenStruct.new
      source.name = 'Website'

      source
    end

    let(:switch_source) { described_class.switch_source(lead) }

    context 'when lead come with SIGA in description' do
      it 'return source Website - SHARK' do
        expect(switch_source).to eq('Website - SHARK')
      end
    end

    context 'when lead come with SIGA in description' do
      before {lead.description = 'Loja: SIGA'}
      it 'return source Website - SIGA' do
        expect(switch_source).to eq('Website - SIGA')
      end
    end
  end
end