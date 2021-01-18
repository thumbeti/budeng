List svs_items = [
  "Video tour of site with market Information. - Rs1 /sqft/year",
  "Site boundary stones (Assist in identifying with Pics) - Rs1 /sqft/year",
  "Tax (Assist in paying with online / offline information) - Rs1 /sqft/year",
];
List mvs_items = [
  "Latest EC (Assist in obtaining) - Rs1 /sqft/year",
  "Latest Khatha (Assist in obtaining)",
  "Cleaning (Assist in getting it done)",
  "Fencing (Assist in getting it done)",
  "Boundary Wall (Assist in getting it done)",
  "Rent / Lease Out (Assistance)",
];

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

List BEServicesChargesStr = ['\u{20B9}1.25/sqft/year',
  '\u{20B9}1.85/sqft',
  '\u{20B9}26.25/sqft',
  '\u{20B9}120.45/sqft',
  '\u{20B9}1/sqft',
  'Half month rent'];

List BEServicesCharges = [1.25, 1.85, 26.25, 120.45, 1, 1];

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