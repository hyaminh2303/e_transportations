json.e_transportations do
  json.array! @e_transportations, partial: "api/v1/e_transportations/e_transportation", as: :e_transportation
end

json.meta do
  json.partial! "api/v1/shared/pagy", pagy: @pagy
end
