require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website - Chat' do
    let(:email) do
      email = OpenStruct.new
      email.to = [email: 'website@jkautoshopping.f1sales.net']
      email.subject = 'Offline message sent by Testonildo Teste'
      email.body = "Offline message sent by Testonildo Teste\nCan't always be online? Let us help > https://goo.gl/zE5uth\n=======================================================================\nOffline message sent on Thursday, August 04, 2022, at 18:56 (GMT+0)\n\nSite : jkautoshopping.com.br\nFormulário enviado : https://jkautoshopping.com.br/\nNome : Testonildo Teste\nTelefone : 10912341234\nE-mail : testonildo@teste.com.br\nMensagem : Teste de criação de lead\nSelecione uma loja : ADMINISTRAÇÃO JK\n\n\n\tBe there for customers when they need you.\n\tHire Chat Agents for just $1/hour >> https://goo.gl/zE5uth\n\n\tFollow us on :\n\thttps://www.facebook.com/tawkto\n\thttps://twitter.com/tawktotawk\n\thttps://www.tawk.to/blog/"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Testonildo Teste')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('10912341234')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('testonildo@teste.com.br')
    end

    it 'contains product name' do
      expect(parsed_email[:product][:name]).to eq('')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Teste de criação de lead')
    end

    it 'contains description' do
      expect(parsed_email[:description]).to eq('Loja: ADMINISTRAÇÃO JK')
    end
  end
end
