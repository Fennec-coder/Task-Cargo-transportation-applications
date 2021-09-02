require 'rails_helper'

RSpec.describe "ClientsControllers" do
  let(:client) { create :client }
  let(:params) { { id: client } }

  before { sign_in client }

  context 'valid factory' do
    it 'has a valid factory' do
      expect(build(:client)).to be_valid, type: :controller
    end
  end

  describe '#show' do
    let(:params) { { id: client.id } }
    subject { get :show, params: params }

    it 'assigns @client' do
      subject
      expect(assigns(:client)).to eq(client)
    end

    context 'see another client page' do
      let!(:client) { create :client }

      it 'assigns @client' do
        subject
        expect(assigns(:client)).to eq(client)
      end
    end

    it { is_expected.to render_template(:show) }
  end
end

