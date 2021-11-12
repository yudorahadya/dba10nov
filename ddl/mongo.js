print('Start #################################################################');

//db = db.getSiblingDB('api_prod_db');
db = new Mongo().getDB('mutualfund_employee');

db.createUser(
  {
    user: 'aplikasi',
    pwd: 'aplikasi1234',
    roles: [{ role: 'readWrite', db: 'mutualfund_employee' }],
  },
);

db.createCollection('region');
db.region.insert (
{
region_id: 1,
region_description: "sumatera"
}
)

db.createCollection('territories');
db.territories.insert(
{
territory_id: 1,
territory_description: "payakumbuh",
region_id: 1
}
)

db.createCollection('employees');

db.employess.insert(
{ 
employee_id: 1, 
last_name: "wardi",
first_name: "metronom",
title: "programmer",
title_of_courtesy: "MTI",
birth_date: "1990-01-01",
hire_date: "2020-01-01",
address: "padang",
city: "padang",
region: 1,
postal_code: "26253",
country: "ID",
home_phone: "08123344555",
extension: "0",
photo: "",
notes: "",
reports_to: "0",
photo_path: ""
}
)

db.createCollection('employee_territories');

db.employess_territories.insert(
{
employee_id: 1,
territory_id: 1
}
)

print('END #################################################################');