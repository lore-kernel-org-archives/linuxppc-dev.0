To: "Navin Boppuri" <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Flash Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1059784500"
Date: Tue, 14 Aug 2001 21:32:18 +0200
Message-Id: <20010814193223.B316010CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_1059784500
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 14 Aug 2001 14:15:36 CDT."
             <3A494DE356A49A40B37442E1E0D9F3B506341C@ptah.ad.newisys.com>

In message <3A494DE356A49A40B37442E1E0D9F3B506341C@ptah.ad.newisys.com> you wrote:
>
> Coool!! Now I have the flash driver registering itself and telling me
> all about the number of partitions on my flash etc. etc. I have the
> flash device in the /dev directory. Now, how do I use them? I remember
> using them before using the dd command.

That's one option. If your write() calls are the same or  a  multiple
of  the erase block size, the driver performs auto-erase. You you can
just read / write it.

Attached below is a small patch against busybox to add flash_info and
flash_erase as busybox applets. [That's  part  of  SELF,  our  Simple
Embedded  Linux  Framework; I just wish I'd find the time to complete
the documentation so I could put it all up for FTP...]

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He only drinks when he gets depressed." "Why does he get depressed?"
"Sometimes it's because he hasn't had a drink."
                                     - Terry Pratchett, _Men at Arms_


--==_Exmh_1059784500
Content-Type: application/x-gzip ; name="busybox-0.51-flash.patch.gz"
Content-Description: busybox-0.51-flash.patch.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="busybox-0.51-flash.patch.gz"

H4sICCR8eTsCA2J1c3lib3gtMC41MS1mbGFzaC5wYXRjaADtGmtz00jys/IrGi0Odqz4lWRh
DeEIiQM+8qDsUHBFKJcsjW0diuSS5MQ5Nv/9umdG0uhhh1y4uv1wFOVYPdM9/Zp+yXWwnckE
thcwXoS3Y3+53WrstZuHvjdxpo1Z43zQf1e+tLG9vb0GSRuaEfx94QF0oP282/m923kBnVar
vVGv18vxiih7EuXNG9jeeW78DnX8fAFv3mxAs/mbzSaOx+Dt29Hx22HvIg87Oj75NHyfh/bP
jjbqKuDkYPh+1BscDHsl8P7Z8fkGqOBBr5cniaDBwelRf/ghvzI8/DA67Z/1v2zUy/Vszucu
i8JSRSdrRU1n0bTPzIaDeQCwC+0/ujvtbntvhaoTxPW6bu/+QcqmP+0OV/dvzgTlSjQI2sHH
jye9iyqKahtAn6Mr0/EMGOGWo/5g9Gk4GL3tn9UQlXkoOyo3JaHqPKHkmuFsxAIzZEgwfcjR
5TTrq2hye+VIOt7EjynS93UEVTm5pRNSASO28PNeOcstrUjUsEqsnVkvWryIvtqCBatnkNdb
vmW00O5GZ2+HzF5vbqE8W1A9rMGhP78NnOksos0tDj7qnX2BoT+JbsyAQc+bot+zwPGmfPWz
706mpjeFI+Z9N+DGfmMzb9mwGV89cF3g5EIIWMiCa2Y3aIEvPj0yI9blXDXp/w60W91Wu7vz
HJ6KDQN27YSO73Wh3WgLYHOjTg7hWe7CZqBLDTRmugJ9xYLA8xuz1ypsYnmRm4OFke34RZjr
jAtAEjgHXHgObs7vvA2bjm8Vj0J4GJlRCTi6nbMwB3cdb7EUJi1fEQgbdceLYMqikbe4GrMA
qpbvhRFYMzOALQMWXuhMPQwcro8m2qq9JBRiw7FA3Wld2Z55xfgyW0Ys8IAI5y8oVAlqBlPL
kIhb+HCNN+sH3kdac/D6YKiYm0GExDTU28KKgE7EjzGBlCuK2/FPCgzYFI0dr22Jx3SZiDoR
7cDF5IHWBYcSjz8QNCu8P5mELDIgdP6Fd3w+ip/nI4JwyTWpBtgHLpcAOhOoVklmeLIPnRps
bkLyuFurAYmuhTP/ZrQIzSmDKmlZu0txJzYS9OfM43jXX9vfDDgfDY4+DxD7FbQkiTl6rR8k
ezgVLWDRAo1R7X3pX4yOD/onnwa9HP0JabdKWt9EFT+WIukV2cV8dj6oIr1GGI0Cm12j3CCi
78eDwcXo9GD4IVUPd3jgPPA973oXFKORI7LJY1ki+yBLRKqBbi7dJMQAQSs+qaDoPjXFeGIB
SVyZrutbUCU81P3+Ppx9Ojl5pP5LhB/03vXPz4QKxOG/wtBkGiShNbeQqGlDcgW4anho1ITA
6Uosc1Woqlq4SbWtRK8EDWs1oqJlVZOwrAtquuB5NdOS61X6IRcS2kk4URVUrqH1pyGSvNIo
c0L1K33bbn9DL5YRSRP3HaB8mwgF2h0wN2TSXCndVp5CK7GQtBEPDPs8ThAybgLFdIRNyVbT
0Hl5nIKbme+ylBOxxi05x5QTIa7ew42YfeBjYtWKDdWKa8P3t4CBVbLXWlbcZe3S0w2hQ9wd
Rzd4/Rpzaxr1hNZEqZATTgBTFcXRsdyWvLrDa86xSk3IuWcwMR2X2T/lN1xpqgFKNYYhybGY
oq6cHBM63OGP4CBj+eiB0Ho9ZpYyF8JHMtKILV+dbxwhZFbkBxRuUriAKZmjoE3x5aWylBJP
dVo0cqVjQ3xitbJDNjYg8iPThcouPdV0jqjpedMnltdK+S+sKTJI/0h2FIHiIP5d2vBh7pD3
B3F4zi3W+IW44rGR6zk1Jl4j/1quj2cgXxyZIBnKw0+Hh73hUAmv3MXQwoI5ngMxr0Qzxc+E
m5HUarnFI1QHE/qmvFmK0JPYuFglovQG6JWwC2OM3GJvFyohGQ1k2WGApCZELispys/fofN5
Tvup02nnirN31pytqOkCFXNMmQTswLlGPm6caKbko3Axn/sBlXdYSs5R96HAy9yRgLlYh14z
9G6uaWsRBAwvYkKmwZEEpi6QdHDCAiKP7bG9ClQMQeBmhp4GehwB9fVU1BjTiI1P1ZG4Gdv7
SSh9KdIxVcd0fV3mTVEVSEYyEKE6uOckaaSeBAdCLVGGODY+8iGBLFvx3hfRxJ3T1gS2MorY
/0KGYiyWeiWTSiTGeJVqrAZ//imUxquyMXP9GxnascE0ZTinS1stHPIaUjWCrOJ+QErMHPuo
wwIxDXudCPumNFooDNAaWi+keOoyM4yS+1+gw1N5zEClXG1xxCu/f2rABs/HY7w4Fo79hWeb
wS3osWH0uHKtLLrxLjpiH9GX+xUbk0Ea9LX0KsetjZMslXJqwJpkUIvz2j1V1+q0V8h65Afb
6cWJFarsew2qBjMEMrFeGoIvYTuWoTAfraQhixmyve17zyK8aS6LGLrgre+p9bSwtqxhiyl6
V5Re+5is3UK2ruXzsjSQyqSoxhRIc4WFpAVWp2xQC7pcpZlyjkFDka5i66LwVovneCs6VO0/
KPfKvb0k15PD05JIPwXXTRrkMApkxcCHObUH9gAYZFP1vlTqQyhZimN6DkwaeKI60xgjwffk
sLQxU/YkevxsBpQQUFDhLHTXOX1b7IexM51i5oxmJikkvchyPkEh6G+Yr2Kr6dAFXWQGXcnI
mUoHn1fVOXf3zYrCwrDo2nTlYCefBKLMdIXjW7LwlhrZCqkJetZ6Rv0qD7YztgS0JjoUVrKS
AXHN6vXwpYzI/1wgPy2UOw23ktIlJ8UVRIwlZX4icKuWie1YJjgRHarSqoahZXpkMPRPupoV
C2/CZkCxctOqUZJq0XyHE85s/rJic8wTnkgGxvMMbLhvx4wETeQQTqKQq7h+6dE/smXwdlst
fu9yfSmeeUX6GlOhYlHZ4imyZo+z1xyXPy317RDLOmuGfiK2WnSZn31/1k2+f+DfiQK8QpLt
1ktNKAMdXrCSXBmBcKUgn2aROwnyaQFZsCMNL/0vY/i79QN5XjOtnseL5VXjeAX5wdN4gftT
w/i2eAfzPxjGU6kF/5/IP3AiXzoqT948/UUn5eqU6kkypfq56XV2eH1+dvKPv+74WhlcP2Zu
/WT/cczExUAfqQVXJq++qJ+rhHpS6vD9ucotLdz2s1M//IxmmNtkIaCUcXfqed1L79Ibija/
Y2NANQDE+/dFwLlAuL1EemMnMni7oQORH4iW0uAPycEhURPVCY9ncfnZwfJTBLiZMx9ZnL6E
IN0bx45mKZLSsRqQGznfN6pfNeLHgJSnLcbX5YP97PD61032H+klD2nwEwsLS1HgrthdgHM5
UMKGo/UCWw6e2NGm0gf2eAmKUYlalKHsV1CrYqIIzLRmSf3p5JsO2U3moD8xGVUHiGtGkmtw
aT1nkyfKNale+45dyw77tHsmfSvej+QdTX1DorqZ8o7kv+dkpa9HflUskg3eOsfjQpa6nRqM
im6X9bfUo7C6SV5JiPctjnwjUwZfZf0ya69pd8rrQZ7kSn+II1eKVaCKol0sGP8RTrsFWBdh
JbfTXlEASrT1td+u+AkO/enw32KApj/lP7SBJmzzd9FNFlnNuRmGNzZqFC5pSxa2AelvmtSa
IXCuHdOVef0StaXLZZE9CLMMb7JwM0gfA16u5FKYKQfAp+zKD26x4FxHki3Nq7nLVKpPlXVo
IkeitDLbnEaeinjBf59E8PX8+HjYu4CT3tm7i/ffStgRhPIiijlFqUjUtIb+VfpSwIkawg6I
Fw/axNS3y5vcamt5dlYzeE9WxW+y60U4PYjONzQSEpD7N3cXGJrnpGfsdrDbInzsmyBcTCbO
Msaqkg0wdOMnZXes5+eN2kp51+hfzDgVA8DOKey1O9+FHZJfxfEfReUNgK6o57ZkVPtvIPPA
1XgoAAA=

--==_Exmh_1059784500--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
