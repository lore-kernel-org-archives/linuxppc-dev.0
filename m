Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2538E2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:52:04 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id lf10so8679093pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 21:52:02 -0800 (PST)
Date: Wed, 12 Feb 2014 13:51:51 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: set the correct ksp_limit on ppc32 when
 switching to irq stack
Message-ID: <20140212055151.GB15434@pek-khao-d1.corp.ad.wrs.com>
References: <1389932728-25178-1-git-send-email-haokexin@gmail.com>
 <20140121161450.GA3311@roeck-us.net>
 <1390340928.9227.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <1390340928.9227.13.camel@pasglop>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 08:48:48AM +1100, Benjamin Herrenschmidt wrote:
> It will be merged when I come back from vacation. It was too late for
> 3.13 so I'll send it to Linus next week and will CC -stable.

Hi Ben,

Any reason why this is still not merged yet?

Thanks,
Kevin
>=20
> Cheers,
> Ben.
>=20
>=20

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS+wv3AAoJEJNY7TDerrFxzM4H/RfYUe0LqpSaAr5NWOmOuXHx
kZ5NxAXQq3H3DGgeXJsPKsg4wyx2Av56eyNPCZDLAEGFIIjrqSte9/HMl5PnbBc3
+wvT9zge9xO+Sljf8VOxmUMCvwruZosW8p1GvU9x/e6jsqWrTGEd6BFolDZD+jaV
qQeSuGcrf+XiQdQW80aF5w21ovbrpi7m4iof9ZcdeS9giTVD1EVcIaIBPqoIEjvG
99wN0bQVXHX5ZYtKdUswnj6X4WnJ4Nnv2O9/2USPRP4FZzpOVUWfoZ23nrW+XDbJ
eyHb/3kgJ1V6iWe54v5c+SZw7i6W1+sFb2SytY5xcpFjQjWED6k2MVbR7sFF0EU=
=aLOV
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
