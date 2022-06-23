# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PixKey do
  subject(:pix_key) { described_class.new(key) }

  let(:key) { 'email@husky.io' }

  describe '.new' do
    context 'with a valid key' do
      it { is_expected.to be_a(described_class) }

      it { is_expected.to be_valid }
    end

    context 'with an invalid key' do
      [1, nil, [], {}].each do |key|
        context "when key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_a(described_class) }

          it { is_expected.to be_invalid }

          describe '#value' do
            subject { pix_key.value }

            it { is_expected.to be_a String }
            it { is_expected.to be_empty }
            it { is_expected.to be_frozen }
          end
        end
      end
    end
  end

  describe '#valid?' do
    context 'with valid keys' do
      [
        'email@husky.io',
        '12312312334', #cpf
        '12345678901234', # cnpj
        '+5510998765432', # phone
        '123e4567-e89b-12d3-a456-426655440000', #evp
      ]
      .map { |key| "#{['', ' '].sample}#{key}#{['', ' '].sample}" }
      .each do |key|
        context "when the key is #{key.inspect}" do
          it { is_expected.to be_valid }
        end
      end
    end

    context 'with invalid keys' do
      [
        'emailhusky.io',
        '1231231123122334',
        'invalid',
        '551099876543299', # wrong phone
        '11123e45670sdsd00a-e21289b-12d3-a456-426655440000', # invalid evp
      ].each do |key|
        context "when the key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_invalid }
        end
      end
    end
  end

  describe '#value' do
    let(:cpf_value)   { "#{['', ' '].sample}01201201202#{['', ' '].sample}" }
    let(:cnpj_value)  { "#{['', ' '].sample}75928551000119#{['', ' '].sample}" }
    let(:phone_value) { "#{['', ' '].sample}+55998822334#{['', ' '].sample}" }
    let(:email_value) { "#{['', ' '].sample}other.email@husky.io#{['', ' '].sample}" }
    let(:evp_value)   { "#{['', ' '].sample}123e4567-e89b-12d3-a456-426655440000#{['', ' '].sample}" }

    let(:cpf)   { described_class.new(cpf_value) }
    let(:cnpj)  { described_class.new(cnpj_value) }
    let(:phone) { described_class.new(phone_value) }
    let(:email) { described_class.new(email_value) }
    let(:evp)   { described_class.new(evp_value) }

    it 'returns the key' do
      [cpf, cnpj, phone, email, evp]
        .each { |pix_key| expect(pix_key.value) }

      expect(cpf.value).to eq '01201201202'
      expect(cnpj.value).to eq '75928551000119'
      expect(phone.value).to eq '+55998822334'
      expect(email.value).to eq 'other.email@husky.io'
      expect(evp.value).to eq '123e4567-e89b-12d3-a456-426655440000'

      expect(cpf.value.object_id).not_to eq cpf_value.object_id
      expect(cnpj.value.object_id).not_to eq cpf_value.object_id
      expect(phone.value.object_id).not_to eq cpf_value.object_id
      expect(email.value.object_id).not_to eq cpf_value.object_id
      expect(evp.value.object_id).not_to eq cpf_value.object_id
    end
  end

  describe '#key' do
    it 'is an alias to #value' do
      expect(pix_key.key).to be_frozen
      expect(pix_key.key).to eql(pix_key.value)
    end
  end

  describe '#to_s' do
    it 'returns the key' do
      expect(pix_key.value).to be_frozen
      expect(pix_key.to_s).to eql(key)
    end
  end

  describe '#phone?' do
    context 'when receive a valid phone' do
      [
        '+55861107350',
      ].each do |key|
        context "when key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_a_phone }
        end
      end
    end

    context 'when receive an invalid phone' do
      [
        '55861107350',
        'fernando@husky',
        '123e4567-e89b-12d3-a456-426655440000'
      ].each do |key|
        context "when key is #{key}" do
          it { is_expected.not_to be_a_phone }
        end
      end
    end
  end

  describe '#cpf?' do
    context 'when receive a valid cpf' do
      [
        '86110735094',
      ].each do |key|
        context "when key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_a_cpf }
        end
      end
    end

    context 'when receive an invalid cpf' do
      [
        '86110735099',
        '861.107.350-94',
        '+5582998899889',
        'fernando@husky',
        '123e4567-e89b-12d3-a456-426655440000'
      ].each do |key|
        context "when key is #{key}" do
          it { is_expected.not_to be_a_cpf }
        end
      end
    end
  end

  describe '#email?' do
    context 'when receive a valid email' do
      it { is_expected.to be_an_email }
    end

    context 'when receive an invalid email' do
      [
        'emailhusky.io',
        '75.928.551/0001-19',
        '861.107.350-94',
        '+5582998899889',
        '123e4567-e89b-12d3-a456-426655440000'
      ].each do |key|
        context "when email is #{key}" do
          let(:key) { key }

          it { is_expected.not_to be_an_email }
        end
      end
    end
  end

  describe '#cnpj?' do
    context 'when receive a valid cnpj' do
      [
        '75928551000119'
      ].each do |key|
        context "when key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_a_cnpj }
        end
      end
    end

    context 'when receive an invalid cnpj' do
      [
        '75.928.551/0001-19',
        '75928551000118',
        '861.107.350-94',
        '+5582998899889',
        'fernando@husky',
        '123e4567-e89b-12d3-a456-426655440000'
      ].each do |key|
        context "when key is #{key}" do
          it { is_expected.not_to be_a_cnpj }
        end
      end
    end
  end

  describe '#evp?' do
    context 'when receive a valid evp' do
      [
        '123e4567-e89b-12d3-a456-426655440000'
      ].each do |key|
        context "when key is #{key}" do
          let(:key) { key }

          it { is_expected.to be_an_evp }
        end
      end
    end

    context 'when receive an invalid evp' do
      [
        '75.928.551/0001-19',
        '861.107.350-94',
        '+5582998899889',
        'fernando@husky',
      ].each do |key|
        context "when key is #{key}" do
          it { is_expected.not_to be_an_evp }
        end
      end
    end
  end

  describe '#type' do
    {
      'cpf'   => '86110735094',
      'cnpj'  => '75928551000119',
      'phone' => '+55998822334',
      'email' => 'email@husky.io',
      'evp'   => '123e4567-e89b-12d3-a456-426655440000'
    }.each do |type, key|
      context "when key is #{key}" do
        let(:key) { key }

        it "returns #{type}" do
          expect(pix_key.type).to eq(type)
          expect(pix_key.type).to be_frozen
        end
      end
    end
  end

  describe '#==' do
    let(:cpf)   { described_class.new('01201201202') }
    let(:cnpj)  { described_class.new('75928551000119') }
    let(:phone) { described_class.new('+55998822334') }
    let(:email) { described_class.new('other.email@husky.io') }
    let(:evp)   { described_class.new('123e4567-e89b-12d3-a456-426655440000') }

    it 'verifies the key equality' do
      expect(cpf).to eq described_class.new('01201201202')
      expect(cnpj).to eq described_class.new('75928551000119')
      expect(phone).to eq described_class.new('+55998822334')
      expect(email).to eq described_class.new('other.email@husky.io')
      expect(evp).to eq described_class.new('123e4567-e89b-12d3-a456-426655440000')

      expect(email).not_to eq described_class.new('email@husky.io')

      expect(cpf).not_to eq cnpj
      expect(cnpj).not_to eq phone
      expect(phone).not_to eq email
      expect(email).not_to eq evp
      expect(evp).not_to eq cpf

      expect(cpf).not_to eq '01201201202'
      expect(cnpj).not_to eq '75928551000119'
      expect(phone).not_to eq '+55998822334'
      expect(email).not_to eq 'other.email@husky.io'
      expect(evp).not_to eq '123e4567-e89b-12d3-a456-426655440000'
    end
  end
end
