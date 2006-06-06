Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 057A467B46
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 21:38:49 +1000 (EST)
Subject: [snd-aoa] more layout IDs
From: Johannes Berg <johannes@sipsolutions.net>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TGIp/IFy61jJCF63aV9U"
Date: Tue, 06 Jun 2006 22:19:12 +0200
Message-Id: <1149625152.32002.38.camel@johannes>
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


--=-TGIp/IFy61jJCF63aV9U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have tentatively added support for these layout-IDs to snd-aoa:

36	tas
47 48	onyx/topaz
49 50	onyx/topaz
56 57	onyx/topaz
62	onyx/topaz on a single bus
66 67	onyx/topaz
76	tas/topaz on a single bus
90	tas
94	onyx
96	onyx
98	toonie
100	onyx/topaz on a single bus

If you have one of those, please test :) I based the info on the
Info.plist from Apple (thanks to xsltproc & python), so this should be
all possible layout IDs that Apple ever had.

Again, to find your layout-id:
  find /proc/device-tree -name layout-id | xargs hexdump -e '1/4 "%d\n"'

johannes

--=-TGIp/IFy61jJCF63aV9U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIXjPqVg1VMiehFYAQIQHxAAqr1E4JvL58w4Pn8/F4h6Q8giGIEmES5B
YHS71WxDeuL6rjk4XuaZRz4uz8zim0JaOB00eJZgG5y4HcfzMgZ83FRex7TujlCT
tyEd3xum+hTpoQu/D4gFzjDS6LissZatq9SpkdAPGoKMzcg6RtRlq8iXNGrcbNyS
i+xobKW+f7ACnhqlEjU7sCIuNcWMYFD7S/Qjafd3jEnU7xkbo2vQncf608t+CXVj
Osj9xIo1ZbwNHmPmLbsxZsz+4Nid2orIQ3HlsjO+pRpJZ/8feNqHFHPsEle+LCH3
r3Bgbk6J80wYXIY3Uz8U3QYAblt9BVDezq/LM6BoTe6OHs55hmkTSr7V2ETtZ+hV
/O7ZhtLQViG6NG7q4Hv0ynM5HD7j1EPSr4AWx1A7SFDfkVCq/37RSqAg1w6pFbmz
mQNiIQ251GC4pMUrvxyLO3d2tJsOcM/e/BGIJVPN3S0YO7rds5FWBOulr8xgEFXg
2ipqvBP3avRNZ5blwzYDcDVNGGoHdduJlfhdW9rfA8Roqux3MCvLJjCuVdQ49aDR
nEU2OxNZlCDtGjoiQi6mHx5/nBsInNtvr9XV+VvWbhPk8tYBhncyokXL+uJBqllE
4MTcvYObx/coXNe81Lg6IBNpcxxpBZHJxv1bMQB99lNxfVB155aXemo0OB2IlLvb
++wLax6jhb0=
=IgM0
-----END PGP SIGNATURE-----

--=-TGIp/IFy61jJCF63aV9U--
