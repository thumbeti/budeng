
int vigilance = 0;
int cleaning = 1;
int fencing = 2;
int compound = 3;
int ec_khatha = 4;
int rent = 5;

List BEServices = ['Vigilance of Plot',
                  'Cleaning Plot',
                  'Fencing Plot',
                  'Compound Wall',
                  'EC / Khatha',
                  'Rent'];

List BEServicesChargesStr = [
  '\u{20B9}1/sqft/year',
  '\u{20B9}1.25/sqft',
  '\u{20B9}21/sqft',
  '\u{20B9}100/sqft',
  '\u{20B9}1/sqft',
  'Half month rent'];

List BEServicesCharges = [1, 1.25, 21, 100, 1, 1];

List BEServicesGSTs = [0.18, 0.22, 3.78, 18.06, 0.18, 0];

List BEServicesInfo = [
              'a) Monthly video tour of plot with market Information\n' +
              'b) Site boundary stones (Assist in identifying with Pics)\n' +
              'c) Tax (Assist in paying online / offline)',

              'a) Cutting un-wanted-grass / weed-plants / shrubs\n' +
              'b) Keep the waste in one corner or center of the site',

              'a) 5.5 ft height of stones with 3 inch x 5 inch thickness\n' +
              'b) One stone for every 10 feet & corner stones will be supported by one extra stone, totally 18 stones.\n' +
              'c) 10mm gauge of 2 layer Barb wire with 12mm gauge spikes. 3 horizontal lines with 1 feet gap and one cross line\n' +
              'd) 4 feet x 4 feet MS gate with lock & key',

              'a) 4 ft height wall (half feet inside the soil, total 4.5 feet wall)\n' +
              'b) Solid blocks will be used\n' +
              'c) 4 feet x 4 feet MS gate with lock & key\n',

              'BE Liaisons with Govt. officials. Procedure & Fee details will be shared with the client & expenses born by the client.',

              'BE will manage to get tenant and complete agreement formalities. BE charges additional half month rental as service charge.',
];