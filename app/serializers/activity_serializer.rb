class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :begin_at, :end_at, :description
end
