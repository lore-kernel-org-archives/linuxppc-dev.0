Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02C6EDDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 01:17:57 +1100 (EST)
Subject: adding more machines to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lExDsNqLsCgsxy6Z8fYW"
Date: Thu, 23 Oct 2008 15:44:21 +0200
Message-Id: <1224769461.6002.12.camel@johannes.berg>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-lExDsNqLsCgsxy6Z8fYW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Andreas (Cc'ed) asked whether it was possible to use snd-aoa on his
machine, a PowerMac3,6. It appears that it is fairly easy since the
machine seems to use a regular i2sbus.

To identify it, after looking through my device-tree collections I think
that the "device-id" property of the sound node would be the best bet.
This is the value "22" for a PowerMac3,6.

However, this node is also present on at least a PowerBook5,2 (value
35). Can somebody who has such a machine please reply to this me?
Sjoerd, I think you have/had such a machine? I'd like you to test a few
patches once they're ready, and I need to know what connectors it has
(line-in, mic, headphones, ...).

However, even if that works, I'll also need to know whether there are
any other machines that have such a device-id property so that making
snd-aoa-i2sbus aware of machines with device-id doesn't break those that
I don't list. Therefore, if you have access to a machine that is
newworld and has audio, please run the following commands:

find /proc/device-tree/ -wholename '*sound/device-id'
find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd

and let me know their output. No output is fine, I'm only interested in
those machines that have this property. If you have access to a DT
collection (hi Ben :) ) I'd appreciate if you could run it on that.

johannes

--=-lExDsNqLsCgsxy6Z8fYW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJAH+xAAoJEKVg1VMiehFYP5oQALVCV1wi8wNaI2JXK+ClgYRb
/AdUDZC9Q7WtdLhRjghxVAqxO1dtxIQbGp/pxHMv55F+gdxNhBLbAiT0g7ZE+QJ9
nFFHeyjsRifEIacI0q0QRTmdrvtKJkhrstoIzP4EZ+tALQ7bK8tDWGocpWqXTXi2
ejbvC9Q+m3OU4zTO+Fcy9CIv+dyVdA1xw/pkiUJWdadYLJaB6dhpmml8KaKdA4s7
0rz269dDl/REjy8zaxyfwsMhiLX3/KLqNlvdmHtxLTIgzxOKrfSmUV6AUNUZ4lLE
c31F0WAVm6SaCTHPiQloOr3X/RuIwJGKWiSFUfu1ex+BQPbj3RaZLMazl4GkBhmo
OCiDwEQvRPH3Y92f8eI11dLr52SB78JXbZcwCg+gzH0TRwIf20l9tpTffLSK6Eh9
D4RPF7m3BvtgVn0E6UtTwkFtfeMxmoAXQIlcCnYw2/c3MOlic1iAg73SmfyEQb22
l0FX4qqlo2h+1aa6WeV28hFPr/ZDHGvJ8skaxRSVaNQQ3b5T+eMZJB4NtBlfvpnT
yy8I64uww+IEpfwQBwnbiX7gwXF1V0OnRsLmGQojWGTnHKh778f5kSERIv0GK7G+
a/qtkCoMhbqVa3kZFHyZUT4MZUMGvAFrdAHfNXaE3hqbS21pM3AO0ADKroGIkOV3
yPt90eVPj/n94aazwCjI
=vaW3
-----END PGP SIGNATURE-----

--=-lExDsNqLsCgsxy6Z8fYW--
