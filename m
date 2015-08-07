Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D5561A1D6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:28:47 +1000 (AEST)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A132914010F
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:28:46 +1000 (AEST)
Received: by pdbfa8 with SMTP id fa8so34617pdb.1
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:28:45 -0700 (PDT)
Message-ID: <1438917967.6796.3.camel@axtens.net>
Subject: Re: [PATCH 1/4] cxl: Compile with -Werror
From: Daniel Axtens <dja@axtens.net>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 07 Aug 2015 13:26:07 +1000
In-Reply-To: <1438917941.7605.19.camel@neuling.org>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
 <1438917941.7605.19.camel@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-RUndw7vuCuAtPqs+6RC6"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-RUndw7vuCuAtPqs+6RC6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Do you need to put this patch last so that you don't break bisecting the
> series?
>=20
The warnings fixed in the rest of the series are from sparse, not the
compiler, so they don't break building with -Werror.

--=20
Regards,
Daniel

--=-RUndw7vuCuAtPqs+6RC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVxCVoAAoJEPC3R3P2I92FoEwQAKhdy0cjIBgp5bqlfn+YaviB
wqyyDXU/LnB0igrShb12WbhGzBYoi1M51+mu4nRmoUGhJLY/lexNq/+xFd4H2x0J
S/J8xCbyK/GuSmbKTfJP9sLfV6cu3lXD7UtgbBLkf5uNujTYaiW2lhjznKRZXFPW
RfMV75Ki/rSZvegqvqKwzTeZvW1glqvFOnfg0BDb920FlGNvDFXBBtLpMaP5fw14
/LZfWVi4z52nOPk3F9XEfmirw3utzhffL6w3P/SkiY1kjXvVqo+HHBgf6eCi/zbv
4ONlt669TYfF14dE6HZQyfWvhyLhPlDKA1xtGfKM2kjEe9258ATGwcLIFaQSBf22
GTJkKWXYJ2M3y0V5qKCH6lilSc9Ek6YIDWJZtG0vwozVYwSqWn8L2meqyIsWYXWc
yNS+6/dFftGCZHxXv868vaCt2VcyluyGv5roMyV9a2jIWwPdMMCU0tGWVDdoetmQ
Fs6A0mwXroHEZF71WdiiUM+rL43hJJ3x+MldFAM8uzWFDiZ/tC1oDWlohf7Yo5tP
sEZTX4bjf7w5ADwOR/vfE7GGaKqWAE4ZR3/1rG0iWXPlX4srV0soK5461Qj6JYBo
a5PCX0Iam0RuJe8oIeKlEty+e86tqoA+Gq4dfetQd6tvd6dWcp69zxrGTDCG32D2
o5xb4DLCymu6IVwtRpqn
=7kyg
-----END PGP SIGNATURE-----

--=-RUndw7vuCuAtPqs+6RC6--
