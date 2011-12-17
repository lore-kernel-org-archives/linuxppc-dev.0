Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B491B1007DB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2011 01:43:31 +1100 (EST)
Received: by iaae16 with SMTP id e16so4926898iaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2011 06:43:29 -0800 (PST)
Message-ID: <1324133097.4240.32.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 1/2] mtd/nand: fixup for fmr initialization of Freescale
 NAND controller
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Sat, 17 Dec 2011 16:44:57 +0200
In-Reply-To: <1323682853-10750-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1323682853-10750-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-/JZO/7SaMYdPioONr0Wt"
Mime-Version: 1.0
Cc: scottwood@freescale.com, dwmw2@infradead.org, kumar.gala@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-/JZO/7SaMYdPioONr0Wt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-12 at 17:40 +0800, Shengzhou Liu wrote:
> There was a bug for fmr initialization, which lead to  fmr was always 0x1=
00
> in fsl_elbc_chip_init() and caused FCM command timeout before calling
> fsl_elbc_chip_init_tail(), now we initialize CWTO to maximum timeout valu=
e
> and not relying on the setting of bootloader.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>

Pushed both to l2-mtd-2.6.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-/JZO/7SaMYdPioONr0Wt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7KrpAAoJECmIfjd9wqK0oCEP/2cZPibX5JVUT+u5lTmEIOmD
rrik5w2bub1dJ/RwVTrVifS8tvgKcsxXniHmvOBINVtJBHfZQum2D6T9KceSJOAN
58KY15CcVp3UPfnf4AM2y5t9R1ZQ7CaGFImBTzV46KdSvQGSOUxlO5F4o6dfB0ah
nOZNg2E7OJ8SGwJ+Q+o/zm/mjlBLqAqpeTysX8Xg4Ad5XYWpzKOGOVNAL53Y2Uir
yqFtpYR7IAUv6yJUnG/KG77yYM1UgfPP94LZvBD6vX+LkOa7xwIBCNGR2f6BWdBF
sAS0ueNwRjFQk+IEHpTvdoqQPHZSXA0fTTpHecIZ6EgVIn7/3gIieED1hx/lNX+B
RZKPtRw6IUM24pVqQMHt8kiHVc/nn/1FzGsFStlanDoq/HnKHiiaCcVqy0LGGPS6
kcuHc/0aDNv9U0/pDMhXFiRCuHwPKjbeOcEta9Twgp8XhCs3hGsUCaDvuHJBScdZ
0JYd9vU3+CT4j56IEIKCrZJEO1n1VouY6rXcDmPmKmD6lhzoBXiRa6jrOUbu80sX
Nx+HO9kE4vT0ZXyfndlP1BSfODNtm6mUlgBxuS8ZhMywM2v2vDGa2Z/SwYLrzWRy
jSS2T39CeulOxfooowKT4yyQPebpN4xpTDUm+pFH4u0laL1kv2VG5we/+WJ4Ymc/
KqwsmD5gcK+wBtd4KSlK
=3ZGR
-----END PGP SIGNATURE-----

--=-/JZO/7SaMYdPioONr0Wt--
