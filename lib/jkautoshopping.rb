# frozen_string_literal: true

require_relative "jkautoshopping/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'
require 'f1sales_helpers'

module Jkautoshopping
  class Error < StandardError; end

  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        }
      ]
    end
  end

  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash(/(Nome|Telefone|E-mail|Mensagem|Selecione uma loja).*?:/, false)
      source = F1SalesCustom::Email::Source.all[0]

      {
        source: {
          name: source[:name]
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['telefone'],
          email: parsed_email['email'],
          cpf: parsed_email['n_do_cpf']
        },
        product: {
          link: parsed_email['page_url'],
          name: ''
        },
        message: parsed_email['mensagem'],
        description: "Loja: #{parsed_email['selecione_uma_loja'].split("\n").first}"
      }
    end
  end
end
