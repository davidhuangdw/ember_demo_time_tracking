class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :begin_at, :end_at, :description, :type_id
  # belongs_to :type
end
