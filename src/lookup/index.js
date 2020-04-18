const Maxmind = require('maxmind')

const dirTree = require("directory-tree");

let ipDB;

exports.handler = async event => {
  const optTree = dirTree("/opt");
  console.log(`opt directory tree: ${JSON.stringify(optTree)}`)

  if (!ipDB) {
    ipDB = await Maxmind.open('/opt/nodejs/ipdata/GeoLite2-City.mmdb')
  }
  const responseBody = ipDB.get(event.ip)

  const response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json'
    },
    body: responseBody
  }

  return response
}
