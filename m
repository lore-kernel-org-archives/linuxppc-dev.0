Return-Path: <dedekind1@gmail.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 3A618B6FC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2012 21:07:16 +1000 (EST)
Message-ID: <1337338834.2483.21.camel@sauron.fi.intel.com>
Subject: Re: [PATCH] mtd: Fix typo in Kconfig
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Frank Svendsboe <frank.svendsboe@gmail.com>
Date: Fri, 18 May 2012 14:00:34 +0300
In-Reply-To: <1337287389-28386-1-git-send-email-frank.svendsboe@gmail.com>
References: <1337287389-28386-1-git-send-email-frank.svendsboe@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-PH2HGrvoGLczPATUGpnH"
Mime-Version: 1.0
Cc: dbaryshkov@gmail.com, linuxppc-dev@lists.ozlabs.org,
 randy.dunlap@oracle.com, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-PH2HGrvoGLczPATUGpnH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-17 at 22:43 +0200, Frank Svendsboe wrote:
> MTD_OF_PARTS and the default setting is not working due to using 'Y'
> instead of 'y', introduced in commit
> d6137badeff1ef64b4e0092ec249ebdeaeb3ff37. This made our board, and
> possibly other boards using DTS defined partitions and not having
> CONFIG_MTD_OF_PARTS=3Dy defined in the defconfig, fail to mount root
> after v3.1.

The commit was released in v3.2, so it not v3.1 probably?

> Signed-off-by: Frank Svendsboe <frank.svendsboe@gmail.com>

I've amended the subject to make it look scarier than just a fix of a
typo, added a tag for the stable tree, and pushed to l2-mtd.git, thanks!

commit aa2465b2d5d44defb269ac66a2d2b6e6b8feb399
Author: Frank Svendsboe <frank.svendsboe@gmail.com>
Date:   Thu May 17 22:43:09 2012 +0200

    mtd: of_parts: fix breakage in Kconfig
   =20
    MTD_OF_PARTS and the default setting is not working due to using 'Y'
    instead of 'y', introduced in commit
    d6137badeff1ef64b4e0092ec249ebdeaeb3ff37. This made our board, and
    possibly other boards using DTS defined partitions and not having
    CONFIG_MTD_OF_PARTS=3Dy defined in the defconfig, fail to mount root.
   =20
    Signed-off-by: Frank Svendsboe <frank.svendsboe@gmail.com>
    Cc: stable@kernel.org [3.2+]
    Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-PH2HGrvoGLczPATUGpnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPtivSAAoJECmIfjd9wqK0CQUP/iZJxJ8pMyy7WqxpPY8rWiZu
8TmGYs5Z9fGXcVfS3wDZXSuulk90lifLZSNXsACcjzY/0BV58nhcyuDK84cT6+hy
YKenEk6/N/AB8UTFrj7buTKo5KQ01M2cMPWaVubN8C9rKN+yFlQ8pqrlAuYCmejD
VbC/01gektB0m5SpuRjpZS+Fsmz7kXzb0+viUu4sh0v+xJ3aRAEnJ/ccjeFpyXjP
uC+d8jjqFXyhrc7VoBKOtgGWgIufDFRygkL0LhLkIgL10VUkMTlk3+sTTGFm6UnF
QcP0aiv5Mw7bkgsN/ehscUhahyAeTXyvlvmOvAm8CvSXxaQxDcVyRAUdzEJ258cI
AcWiEtcswiIzL1HxO6CydmmawGw5BkdBPZImqHd8g8g/3N/uSEK5SyS2h357Pvmu
NmakF+NlevxhL5AuEwTbwBZXz1PlD1yGFSxIut76KWMAn+OUGtsk0G6E+qJOQDeh
Ic5A54qsLuGHqHW7eK6PdYvor0fB3Iqs2pxRfVPOXiXjgo+j/C6cCYp8P4l4tlWz
TG6LfX6cae7ZqTc1IFbgNqFnM9g4ilY3ECC8SVdxdQOrHQsngIrnasXht+2a+Rqp
lZGxBc63t3N5WInBZCvXTyPnZt1JiP+HEiEarw9tDqK0gTVsyuX73SfXsuINiHuH
IsgtASpZY3wbZdqtLF9u
=Z//J
-----END PGP SIGNATURE-----

--=-PH2HGrvoGLczPATUGpnH--
