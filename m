Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Sat, 26 Dec 1998 19:04:05 +0100
To: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [PATCH] ADB stuffs (req. for trackpad patch)
Message-Id: <19981226190405.026346@smtp.calvacom.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed is a patch to drivers/macintosh/adb.c (and
includes/asm-ppc/adb.h since there's a new exported function).

The new function handles ADB handlerID negociation (try to change the
default handler ID of a device, returns if it fails). It updates the
kernel's internal table of handlerIDs too, just in case...

It's called by new hardware init code in the previously sent patch to
mac_keyb.c

Note also that I changed the adb register function so that it matches by
handlerID or original address. if you want to match by original address,
pass 0 to handlerID, if you want the opposite, pass 0 to original address.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="adb.patch.gz"; x-mac-creator="477a6970"; x-mac-type="477a6970"
Message-Id: <19981226190543.030739>
Date: Sat, 26 Dec 1998 19:05:43 +0100
Content-Transfer-Encoding: base64

H4sICIIxhTYAA2FkYi5wYXRjaAClVm1P20gQ/mz/iimnQ35N7ISkTXKcaI+oOhWh
uxwVqmhkufYmrGrWOe8aDpX+986s7eCEcICaD157dt7nmZn4vg8ZF+V/nbzgy25a
8GtWyO5VnHChcnnZjdMvncQ4Kxmc5tcQBhAMxkEwHhxAOBq9MV3XreVTdv2o+DlL
4Zgl0OtDMBoPXo/DWvzoCPywN/Jeg1sdR0cmGN9NwGfXQZM3sOBZBlyAumRwGYs0
Y0XEUySzLIV8oeloJarvgAlVcCY74HRN31gV6MhX68N0dhodT999fA97yAzoLE+Y
HO/ZE9N9igmsizhNizlQioCn9mcBQJJgLPICLA6HEE6Aw28QDvF0XRu+4aXBF2C1
XLvgc51lLuIsIo1MSjg8hMAmZiPJhcJMskmVlYMDnRU83lRZKZgqC0FeXcXyK1qn
NPnXOSaDjHDBlUVftunSYbpbVO0T0SQTaVSwf0smFbqur8GxtRaRo/5JzRiXKl/l
mP7dTNrNYc8bopvDvncQrKtHnrlYv7PiFlQOCSZgua4eUQS7wSJ24JyKWwcWAuZL
lgmmXC7KjOrnYl2qOFRx26QxqtRZeAd1Fj2gj0ophv8NaypVUSZKu9uEiidWG++2
61JrmXda+MK6rPUZgL/GSwJMS6u1jy8enH48OfHg7fG72fTv6J9Pp3/AXfM1m/51
8smD0DNd0qOV4RXS3x7Ppu+tJoa+rcFIzqHKTsFW2W2UMYGw6m05ETzTCQ/6Xi1J
Fs9nf55N2yahb3uwNnYRzr0m6InxE2E+GiK8NMYNxoveHF49UpZ1Rv63ptDWVWGh
VdbvRFgjbskUds8ilw+B5mx3cU2+N1WD8AEjurDTyW0+isbZ8PyJ2EjgPhrroeFX
NGfqIMlbs90a1o5ucXTBddtbTpoLZu/ksj2zgjRlYJHFy6YZv9wqhu+dTseuJsVI
D7QejvmwmhQoyFPp/y7wiREGTwxU/9kDNWWLuMwU1QGoDM+S298Hi3gplpcaubt7
THJzorQAYhOADb0mdrnXzEpdtmqbGBt7ajqbVUSofntnN3mjXwKlERuwXmHwa/pZ
7Hmmv7nsuUiyMmXdWF75q1Wid/XlxqrvjcPheNDftep3C28t+sH6fwIhYDCiVYHP
kS5/1VYEpSWXihW6z+6z6tHnfcK8FvgILw4+CHpGA9Ga1bZKIflSoCO4JwpwNBw9
qMVXiuzJmkzTCFobdFWqF4lP9LyAFy6oltTPDRmaYNhFv+A+Rwjhvo0iwsb0JIpo
e4L5A6FYvEveCQAA

--==_Boundary-1_==--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
