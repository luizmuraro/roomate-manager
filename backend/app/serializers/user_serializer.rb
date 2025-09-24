class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  def name
    object.name || object.email.split('@').first
  end
end