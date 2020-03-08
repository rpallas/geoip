const Maxmind = require('maxmind')

let ipDB;

exports.handler = async event => {
  if (!ipDB) {
    ipDB = await Maxmind.open('./data/GeoLite2-City.mmdb')
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
