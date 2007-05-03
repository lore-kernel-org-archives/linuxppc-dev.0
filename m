Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9968DDEDC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:24:07 +1000 (EST)
Subject: Re: patches for 2.6.22
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Rp0Epr26xYui4Pi4aJso"
Date: Thu, 03 May 2007 14:25:05 +0200
Message-Id: <1178195106.13233.108.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Rp0Epr26xYui4Pi4aJso
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'll reply to this message with 3 more patches that I will send as soon
as akpm sends Rafael's swsusp patches from -mm to Linus. Please take a
look anyway, only some register_nosave_region{_late,}() calls are in
these patches that are not possible yet.

I'd love to have the G5 suspend merged even though nvidiafb still breaks
it, I do think it's a bug in nvidiafb and not the generic code.

johannes

--=-Rp0Epr26xYui4Pi4aJso
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOdSh/ETPhpq3jKURAuxQAJ9a0e4WozFwfIi2CfKvO2j3EYJjmwCguFia
pCchm702l8EzIGqIJ9WqqJ0=
=Rn4w
-----END PGP SIGNATURE-----

--=-Rp0Epr26xYui4Pi4aJso--
