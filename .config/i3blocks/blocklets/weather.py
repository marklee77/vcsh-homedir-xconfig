#!/usr/bin/python

from NetworkManager import NetworkManager as nm

import pycurl
from io import BytesIO
import simplejson as json

if not nm.ActiveConnections:
    exit(0)

# http://openweathermap.org/weather-conditions
# 01d, clear skies, sun, moon
# 02d, few clouds,  sun, moon poking out from behind cloud
# 03d, scattered clouds
# 04d, broken clouds
# 09d, shower rain
# 10d, rain
# 11d, thunderstorm
# 13d, snow
# 50d, mist (wavy lines)

icons = { '01d' : u'\ue601', '01n' : u'\ue602', 
          '02d' : u'\ue607', '02n' : u'\ue608',
          '03d' : u'\ue60d', '03n' : u'\ue60d',
          '04d' : u'\ue618', '04n' : u'\ue618',
          '09d' : u'\ue611', '09n' : u'\ue611',
          '10d' : u'\ue622', '10n' : u'\ue622',
          '11d' : u'\ue60e', '11n' : u'\ue60e',
          '13d' : u'\ue616', '13n' : u'\ue616',
          '50d' : u'\ue60c', '50n' : u'\ue60c' }

buf = BytesIO()
c = pycurl.Curl()
c.setopt(c.URL, "freegeoip.net/json/")
c.setopt(c.WRITEDATA, buf)
c.perform()

geoinfo = json.loads(buf.getvalue())

buf = BytesIO()
c = pycurl.Curl()
c.setopt(c.URL, 'api.openweathermap.org/data/2.5/weather?lat={latitude}'
                '&lon={longitude}&units=metric'.format(**geoinfo))
c.setopt(c.WRITEDATA, buf)
c.perform()

weatherinfo = json.loads(buf.getvalue())

short_text = u' '.join(set(w['icon'] for w in weatherinfo['weather'])) \
             + u' {:d}\u00b0'.format(int(weatherinfo['main']['temp']))

print short_text
