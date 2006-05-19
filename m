Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81BB267A5F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:49:55 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87zmhef57o.fsf@briny.internal.ondioline.org>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
	<1148046418.3864.14.camel@johannes.berg>
	<87zmhef57o.fsf@briny.internal.ondioline.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sCZG246nigEpo3johGOS"
Date: Fri, 19 May 2006 16:49:49 +0200
Message-Id: <1148050189.6228.13.camel@johannes.berg>
Mime-Version: 1.0
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sCZG246nigEpo3johGOS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-05-20 at 00:40 +1000, Paul Collins wrote:

> Here's the dmesg after "modprobe i2sbus":
>=20
> May 20 00:35:51 briny kernel: i2sbus: mapped i2s control registers
> May 20 00:35:51 briny kernel: i2sbus: control register contents:
> May 20 00:35:51 briny kernel: i2sbus:    fcr0 =3D 0x0
> May 20 00:35:51 briny kernel: i2sbus:    cell_control =3D 0x0
> May 20 00:35:51 briny kernel: i2sbus:    fcr2 =3D 0x4ef1c25
> May 20 00:35:51 briny kernel: i2sbus:    fcr3 =3D 0x0
> May 20 00:35:51 briny kernel: i2sbus:    clock_control =3D 0x0
> May 20 00:35:51 briny kernel: layout id is 51

Did you have the changed modules installed? Otherwise you'd also have to
manually load snd_aoa_fabric_layout and possibly snd_aoa_codec_tas or
so. If you had them installed the MODULE_ALIAS("sound-layout-51");
should have made it load automatically.

johannes

--=-sCZG246nigEpo3johGOS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3bC6Vg1VMiehFYAQJTCA//Unf5Fe1qymvFXT3OhtfyT16wHkk8p5Or
rR4KbjOk3Cn3B0EVztuYsXdnWPgD1Co0jBfi6vFqS0GR42+AbvfG6FVsgzHO6ZS6
XK5TGCpT2171nGIjsHmTsXzRtGy4X1Smayyx1Bzz7Qz4zycCWNMTeL4oJ9DMhTGo
1Gee5kP0dA7LOT/NMQuUrtfJ6iR2oCqXcCE4ZafHB47759EzpsXWS5MzKG3Mic2B
83jPHJKoNm1Xjz5pJAvV5rYjp89qekcokHQ6LDfuQBcGYTBcp9sWMVOKoi405BCz
JuQ75UNqdUVeWhgFr64pMy0SWx/7oVdO5+qOSXKzknjIOz/ZC4CTkhMcuxBVrjMo
BJlqb0Djdl1lN451jM7uFMOhIrQZmQqUYjW6DXd93pxbYnDsrTS/hqz1h2Qlm2PP
EkEV+N8BUXb37/hNd3sCyEJkIo3KqO8GvKWOCn1Cjhv7sdnaUyTErv/V9YJNiOYJ
XpnDkOAJrLy1tqfl0PZGbpUkm127BEMt3ld8Ch+aeh0g2txuVYn2uvRnPS10Dztv
qT93sPTkvRHENRk2oWab12E/mWBz+LTXVds8ykgM0NywO1Bgu3Jix6SjnrnxJAVV
VF1eyIEDXlMEbcSP5VLq5knf2VXBSrcLYgpEfoUVLx9aMWq9ULZRBSzx56PJwnon
i5EzLgKYhpc=
=0igk
-----END PGP SIGNATURE-----

--=-sCZG246nigEpo3johGOS--
