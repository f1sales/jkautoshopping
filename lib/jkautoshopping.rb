# frozen_string_literal: true

require_relative 'jkautoshopping/version'
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
        source: source_name(source),
        customer: customer(parsed_email),
        product: product(parsed_email),
        message: message(parsed_email),
        description: description(parsed_email)
      }
    end

    def source_name(source)
      {
        name: source[:name]
      }
    end

    def customer(parsed_email)
      {
        name: parsed_email['nome'],
        phone: parsed_email['telefone'],
        email: parsed_email['email'],
        cpf: parsed_email['n_do_cpf']
      }
    end

    def product(parsed_email)
      {
        link: parsed_email['page_url'],
        name: ''
      }
    end

    def message(parsed_email)
      parsed_email['mensagem']
    end

    def description(parsed_email)
      "Loja: #{parsed_email['selecione_uma_loja'].split("\n").first}"
    end
  end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source.name
      description = lead.description
      description ? "#{source_name} - #{description.split(':').last.strip}" : source_name
    end
  end
end
