Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6F2B1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 14:23:35 +1000 (AEST)
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A61861402B4
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 14:23:33 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so51308159pdr.2
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2015 21:23:31 -0700 (PDT)
Message-ID: <1439785260.29526.50.camel@axtens.net>
Subject: Re: [PATCH v5 11/11] cxl: Add CONFIG_CXL_EEH symbol
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com
Date: Mon, 17 Aug 2015 14:21:00 +1000
In-Reply-To: <1439783558.14494.2.camel@ellerman.id.au>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
 <1439538087-32137-12-git-send-email-dja@axtens.net>
 <1439783558.14494.2.camel@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-yZmZ7ke4oE7VJH2PiT04"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-yZmZ7ke4oE7VJH2PiT04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> I'd rather we didn't have select EEH here, instead ..
>=20
> >  config CXL
> >  	tristate "Support for IBM Coherent Accelerators (CXL)"
> >  	depends on PPC_POWERNV && PCI_MSI
>=20
> It should be a dependency here.
>=20
> In practice it won't make any difference with the current way the options=
 are
> defined, but I think it's the right way to do it.
>=20
> I'm happy to fix it up if you're OK with it.
>=20

That's sounds fine to me. Thanks heaps!


--=20
Regards,
Daniel

--=-yZmZ7ke4oE7VJH2PiT04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJV0WEtAAoJEPC3R3P2I92FgQEP/1pioYF0uY+d1zRyO5/2RroD
QMNxGFLvc0TePNg07mkh4u45UC3fM7W+st0+LRSXS/bUZ7g3pyfl5zgba9HKEvRm
jrIYibi0BpkMhVv9SLCC3XItMX5dMaQ3mRCt9rv5ZsWXA+abAZQbPycxCwj0hbhU
c282CqJ/RpayM5lWR6aWYNECnBUKPB/8hk56Aimmc3MXcXRPMBnAoqjqBQvfb2+Q
XzlgpDwEgZh6L1XM6w1YQ5cw9JO+ip/AFgjrAA09EuCBGdBQksZE7V3Tdn+zot6O
VHexA2+LrZ2990jcJZIGG8CfELjwghZ+xpK3Pkj50fCylMiafS9DrAGiMqlnscLU
8BjvXE1OSweSxXT91Xi1OEWFUxX7mzvYRlOZrLQ4cmuJVo2bJ8mu++3aZpI/nCL5
CGrJciZN27DxJFLIpDahYWHm4SdrrogwXcd9n67PNzs1LighxTCaR5HH0Hk4cq5v
UkMchm7cQd6qDy5SkibZwwUqnXgdwmNcYgZa0V5L/jUL0nQmVplUWmguSkepQbH4
qutmzc7irrUCtLw1e++iymP/vy+LYEVVtmPvkitFEuKap0NyxQkE3aA9uX4YrZhK
brVsbAPas1WDT4KIKa3Ae1FUt/wkrsktSBtQn/zFJJVOUcjAlo8a1VBcHShx4MCU
yB9NGq2e8dJ9arhMY/Fz
=xv+M
-----END PGP SIGNATURE-----

--=-yZmZ7ke4oE7VJH2PiT04--
