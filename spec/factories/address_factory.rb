def create_address
  Address.create!(line1: "32 winter Ave",
                  city: "Grand Heaven",
                  state: "MI",
                  zip: "98101")
end