Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64E1667A04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 23:47:05 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <87wtcirw0y.fsf@briny.internal.ondioline.org>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MA9IGmSlGoeVsod1x1py"
Date: Fri, 19 May 2006 15:46:58 +0200
Message-Id: <1148046418.3864.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MA9IGmSlGoeVsod1x1py
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 23:20 +1000, Paul Collins wrote:

> I have a PowerBook5,4 here and I'd be happy to test support for it.
> The hardware is identified by snd-powermac as "PowerMac Snapper" and
> the layout ID appears to be "3".

Try downloading snd-aoa and in snd-aoa-fabric-layout.c change the two
occurrences of '70' to '3'. If it works, let me know and I'll add the
proper entry for it.

johannes

--=-MA9IGmSlGoeVsod1x1py
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3MT6Vg1VMiehFYAQL2sA//WRayLVIzfUiSjV/s2CqGfRT55GsKbANO
0F8NDGF2CQ0TbZq9VPXYjDa88bcnlQYesxW1xEJmWxJflAVT47SEiutEQ+17fEd7
7JAr75JmNDhZnSg0fwD4bYtTFXzBfjV2fWQaC41Fl5sK+UnYSHc2Bxr95xT6f7a5
sTrZSN6QgkYlVHf85LwGJ/q2FZcEIOyEhZa6al43eOl9M+QklML6j2Pxp2YTn6D4
7QzFXFrdvHtYd0Wz89df9QM0/e3TCW3OJZzOmonqAlMxT+J9+pa0k/SmB+yhmWCt
w7E6M7DIdMXSEFNJ+xOFxVdigT6vn915nQj/+CmDBhD0MKELYyfNK44TSRCKponP
4n70iNSR6cDdI4f5qSY0ywvhnFog8mwDzU5CVBFC2Az1dnls9JTTHRBL2bicj2ZI
7RAZGbZDIA0+SoJLx/rN/B4xlacpH1budhc1vEDFOmvPgRq5+U9mb2T8iz7bPH05
5HnanOlN9p3ziaE/nSgTYSL2gx7ZWnNnS6BDPfViUhF06EZc91g090S300KEyFFE
z5f2rhKzAmugtr3X279/ZA/A7S4jlSlfv3tpA6C8Dh1PVltSAqkEvf4CCP+ZUaPM
YkXHqC+FODrTe/2rBhfK3bXRwrCAiiqXQuSG4YIC4zuOjh/1dhzbgK/Gcu4Ya6t3
5uP+FNdCmEk=
=bmqA
-----END PGP SIGNATURE-----

--=-MA9IGmSlGoeVsod1x1py--
