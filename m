Return-Path: <dedekind1@gmail.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 491F32C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2012 00:19:07 +1000 (EST)
Message-ID: <1345818230.2848.315.camel@sauron.fi.intel.com>
Subject: Re: [PATCH] kconfig: remove CONFIG_MTD_NAND_VERIFY_WRITE
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Huang Shijie <b32955@freescale.com>
Date: Fri, 24 Aug 2012 17:23:50 +0300
In-Reply-To: <1345021930-5033-1-git-send-email-b32955@freescale.com>
References: <1345021930-5033-1-git-send-email-b32955@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-1PDzJ60gc12o99kZMjzr"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linus.walleij@linaro.org, wim@iguana.be,
 paulus@samba.org, balbi@ti.com, mingo@kernel.org, kgene.kim@samsung.com,
 linux@arm.linux.org.uk, FlorianSchandinat@gmx.de, robert.richter@amd.com,
 lliubbo@gmail.com, vapier@gentoo.org, a.p.zijlstra@chello.nl, arnd@arndb.de,
 uclinux-dist-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org,
 scott.jiang.linux@gmail.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 linux-mtd@lists.infradead.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1PDzJ60gc12o99kZMjzr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-15 at 17:12 +0800, Huang Shijie wrote:
> Just as Artem suggested:
>=20
> "Both UBI and JFFS2 are able to read verify what they wrote already.
> There are also MTD tests which do this verification. So I think there
> is no reason to keep this in the NAND layer, let alone wasting RAM in
> the driver to support this feature."
>=20
> So kill MTD_NAND_VERIFY_WRITE entirely. Please see the patch:
> http://lists.infradead.org/pipermail/linux-mtd/2012-August/043189.html
>  =20
> This patch removes the CONFIG_MTD_NAND_VERIFY_WRITE in the defconfigs.
>=20
>=20
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-1PDzJ60gc12o99kZMjzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQN453AAoJECmIfjd9wqK0fygP/jeOkZF9bCO9UvLxdQWwpJ/X
H7aSPLawengL92Miwb+4/IrlXWzQ8ecyyK6I5l95AflQBT033Z/AZXMZwf7bcqu+
Y0hI1vgEnLBgqWi11NLe34N+i9W6nGch/fso4TJIteJvyk30ZsDUi/EBldo12OJc
yVW6N/kGVSY3vwqNWQEQS4rdYKHx3n0rbgG2akKg5wGRupFcsO0ZwGpf8jg8f68C
IWshWtDvz0VU4im4c3gOwwWd6Aa1J8FLnbx9nmpgGzqvvqJMpSVOvMSBHvZLOW3g
QftCwlor/KePTFApilhUG0YljPt7I/J61QeO0ALvQQZ0C+mLb1eZcVD4lZOGiY16
4zTBdQLYwJ3wSVBA1svcAmd8wLYIPX/A7lvYk+HBDvzcCWKbp5qi1BFao+WcFXmu
CaooHYF3UZxJrjlUsRvv6ouA0WuEap4Ro8axqwXuwndDTeUxukZ8x5rLc/bi0WnL
+qSFmSFcBdw8Y7AtrBKK4uDxHSI2BY9Su7fQXR1ndOAPZbOu6sl4egvBXURlQEcf
5ycYikXFJR7xe76lPxMKKmUQOIF2VRT2ZOyf+Z7EICSrLhC7nka/p11/sVFHJVYp
dlYwFuhPPyNBbrqL5f0WHXHD69QUeMK8i+qx1sE5VeeWXrn3FU13d8KuSJEJ6SPq
SBKDCFB2OQMnuymBLXHs
=YQei
-----END PGP SIGNATURE-----

--=-1PDzJ60gc12o99kZMjzr--
