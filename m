Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00DF367B43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 21:38:49 +1000 (EST)
Subject: [snd-aoa] looking for layout-id 41
From: Johannes Berg <johannes@sipsolutions.net>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FGHE9lrEHF/Gs4NXkQjf"
Date: Tue, 06 Jun 2006 20:15:58 +0200
Message-Id: <1149617758.32002.24.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FGHE9lrEHF/Gs4NXkQjf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

I found all the other layout IDs (that is to say those that snd-powermac
supports) and except the powermac7,2/3 they are supported and have been
tested but this one is still missing. If you have such a machine, please
try out snd-aoa and report if it works, I think it should. Also, please
tell me if you have any platform-* properties in your device tree
(contact me privately if you need help with that).

Again, here's how to get your layout-id:

find /proc/device-tree -name layout-id | xargs hexdump -e '1/4 "%d\n"'

(in decimal, if nothing is printed out you don't have one, snd-aoa
doesn't handle that yet)

Even if no one shows up with this machine I'll probably go ahead with
the snd-powermac deprecation for layout-id based machines as soon as we
have the pm72/3 thing figured out.

johannes

--=-FGHE9lrEHF/Gs4NXkQjf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIXGW6Vg1VMiehFYAQIEWBAAp5X0gv6TwzJniMeTD9/FOb4bKYbIpTCJ
6P4dmbq6hvLVkPzzgxHXs89MKDCc2at++mxOrjbiVL2+mq4CtbFpZQ7GQ3QtP8Cw
Lh6k/b46lHX7uO4hV1HXLu3fkq9coAbVUmhMp9Dk5XX8Pc6Z112kdDAC1lk8iQys
sXUF3e7uE2eKlymxx4VDq3CsGAPsRGGNHaWXZVZDigY/CrQdAFVhmPiRJ9qihKLa
9iq3gd4SUgJ8yFQFREU7SES8buujNStSJ62imeXQHPGLCQ8+qz6Y/s0qU98CVnoI
3mfcZK5temSu1lzAuZp/2QPbBPGbmSkOKhsi2a/vtP4jOMTWacLNhM/5YUkPLjhn
StYIkSPrsM/5kOSXU9sWf1wvN+XfRhD2U9Jfloo2Ueo9ZhzNIuG2/PFw5xGishhx
xRYYIHfqchafkG5TEsqnryK41gIsesqYuWQ10XyBzvEjNROzM+TnyEQVHt6+5YT7
TxJdXmnWe71h0+OQuaAWWHUUztWP/CVE1axr7pPW13lMzC5ADfNf/uK6oDQGbqQS
YjOFRV8DD4qp4SdJOTovZko8rgsIIAf/6hI2HRMSY2qWZEDBqkuRvv+Tl+ccZDUe
KJgXZaAqX8gGPdBd5OY84MpfRYy5789ItRIBf+t85/VpjRZd7uG3zMXVWcZnWywY
Bg7BKeYFDPo=
=WwUy
-----END PGP SIGNATURE-----

--=-FGHE9lrEHF/Gs4NXkQjf--
