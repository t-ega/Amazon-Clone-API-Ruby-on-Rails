require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do

  it 'should have a max pagination limit of 100' do
    allow_any_instance_of(Api::V1::Authentication).to receive(:authenticate).and_return(true)

    expect(Book).to receive(:limit).with(100).and_call_original

    get :index, params: {limit: 999}
  end

end