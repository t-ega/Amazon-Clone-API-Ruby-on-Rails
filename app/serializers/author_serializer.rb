class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :age, :full_name

  def full_name
    # There is a field in the model that computes the full name
    object.full_name
  end
end
