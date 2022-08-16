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
      before { lead.description = 'Loja: SIGA' }
      it 'return source Website - SIGA' do
        expect(switch_source).to eq('Website - SIGA')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: VALE+' }
      it 'return source Website - VALE+' do
        expect(switch_source).to eq('Website - VALE+')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: VISION' }
      it 'return source Website - VISION' do
        expect(switch_source).to eq('Website - VISION')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: GUTIERREZ' }
      it 'return source Website - GUTIERREZ' do
        expect(switch_source).to eq('Website - GUTIERREZ')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: QI MOTORS' }
      it 'return source Website - QI MOTORS' do
        expect(switch_source).to eq('Website - QI MOTORS')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: SJC' }
      it 'return source Website - SJC' do
        expect(switch_source).to eq('Website - SJC')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: ABS' }
      it 'return source Website - ABS' do
        expect(switch_source).to eq('Website - ABS')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = 'Loja: CAPITAL' }
      it 'return source Website - CAPITAL' do
        expect(switch_source).to eq('Website - CAPITAL')
      end
    end

    context 'when lead come with SIGA in description' do
      before { lead.description = '' }
      it 'return source unchanged' do
        expect(switch_source).to eq('Website')
      end
    end
  end
end
