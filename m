Date: Mon, 20 May 2002 18:26:57 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Armin Kuster <akuster@mvista.com>
Subject: [PATCH] ibm ocp gpio
Message-ID: <20020520182657.B17318@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii

The most common thing I want to use the GPIO pins for is
simple lighting of some LED's. I decided to roll in some timers
into the generic GPIO driver rather than haveing each user of the
GPIO driver be forced to do some form of timers to get a usable
LED visual as well.

I think I got the timer stuff correct but I am not sure.
I didn't bother cleaning it up until I get some feedback on it.

--YiEDa0DAkWCtVeE4
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="gpio.patch.gz"
Content-Transfer-Encoding: base64

H4sICBed6TwAA2dwaW8ucGF0Y2gArVdtb9s2EP5s/YprhhiSZcWSvbxZURtg6IagaDLsSwts
neBYlMxNkQyJdl003m/fkXqjEkqJhxGwZJG8u+de+JD0PGwQZHRLsnyyXC2yCb1/8NPl2o/W
ND1ZgnNyCdscSEAZCYBP9zTLsnj/pEdu8Alnf1x8A+cU7Mv57Me5fQ5T255qpmmW2nrlP6aJ
kJ/a4FzM7encvijkr6/Bck7Pxmdg8tfFGVxfazDICNtkCdiuBnsNNHMyGmkmAPyUJixLY4hp
tGI5ONal6E4Tz4Y0DKsPBx/V/ymwNIpiIr4XyTe2okkE9zSKSAY0h1X6FeIUuyiDrzSOIWcI
VMiPJpqJX4wusTPbLBkw+kAyP6Y5KyD4osPl08Q4d9cvRhDOd2FTNJowfG4XMQ3cpncjDONM
f8Gwe+8+tdfWV9qkSZj+Ppt+wdmauU1poJk83M1cfZPkNEowZ9wsHUPrO00MzZSgbWZTDkyC
hV/gCdtr622aCTu1I6GOGrB0wAaj6ZZFhx78oztXV/rMsahhSIpJnBNJg9Ol4RHHKvlu8WmX
+J/d4t8PMlg1Ke70y4nIImCEnBenFqnFqX/RMKQkN9PEfSohR7dq6wwz9bcOH97/duvf3P58
B0ftFM+xghkcB5Bg+R7HAf8bkyRiq7KceOcfydEYniuvGhZGCWuMER2roRuuCh9PQrEW1iQJ
cEHpQ2k9GDAcdtjl4/4iZCTTJYETslvTjONQYTDAUKTtgFA9pEFhB9AOydDhOjoKEKCqgKrV
qloOd+BW6NnXNfymJ34G9DisguwpAfT4sQhUfqiTfUCka7VQITs00Puma/90rBmquQk9L7hr
X1MnZ0RoAytdrWlQ0G6wYIs2Ewq2dPuYkc9AHz27FajnfPkc8SuCVwSuXNAiaOXybAVKnf6K
XxzbbmML00ynnuMCvXJsfJqmajHxglSR3HCoLge9huapSw8eH7sKSaKAmn6Uy4eve7UK6GG1
VwRavDhjoiERZ9q75lWB8fjZpFOifxesWsMFh4ReCuI9weySp+JF9JQrrp9J/y9i6dgZq/aK
BCVkx5osSZsZ/W9E0j6+cIiqOLwIrLAqs9yh7NZNuxLWF2hOg5LoEK3WEF2KO4leHhtpkgYE
RuI1rs6SIY2xjz8NDfcXfvKenjr85D2bOeNzcfBuNIOPOaeyAf6pc3IV4i1KxOO6Z72//Xxz
hwf2Ae9ZbrJMiBUrBQYlCH4nKC4KMBJaA7LF4QLNuT12HISDqJzyIjAYiBigFl0+EmckymFk
QKXCervG0GaukCjzePTLrzd38ENRQPbuON6JVNXIxmJy6UV7bygUrzEvVncdo9OVcwO8pODP
0qzq5qJLAfCgiI0B7/DQPG8QuO26FArFufrA4uSZqbYP/h/9VFafXKV89+tgMXlauEmWjPLz
tnJLVUhzAGWNQ0+RV4HCV3nJA3n/9n2yw+r7FznwXKvSDgAA

--YiEDa0DAkWCtVeE4--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
