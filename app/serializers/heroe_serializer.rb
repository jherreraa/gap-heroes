class HeroeSerializer < ActiveModel::Serializer
  attributes :id, :name, :real_name, :species
  belongs_to :universe
end
