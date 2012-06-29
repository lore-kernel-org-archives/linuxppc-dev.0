Return-Path: <dedekind1@gmail.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 4EB75B7016
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 18:25:26 +1000 (EST)
Message-ID: <1340958563.3070.132.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 2/3] mtd: delete SBC82xx/SBC8560 MTD mapping support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 29 Jun 2012 11:29:23 +0300
In-Reply-To: <1340740469-31445-3-git-send-email-paul.gortmaker@windriver.com>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
 <1340740469-31445-3-git-send-email-paul.gortmaker@windriver.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-9/21tXQP4WOSLufDLbyO"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, David Woodhouse <David.Woodhouse@intel.com>,
 linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-9/21tXQP4WOSLufDLbyO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 15:54 -0400, Paul Gortmaker wrote:
> The SBC8260 support was dropped back when we moved from ppc to
> powerpc.  We are now also dropping the support for the EOL SBC8560,
> so we can also delete this mapping support, as they were the only
> users of it.
>=20
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

You forgot this:

diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 68a9a91..deb43e9 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_MTD_SCB2_FLASH)  +=3D scb2_flash.o
 obj-$(CONFIG_MTD_H720X)                +=3D h720x-flash.o
 obj-$(CONFIG_MTD_IXP4XX)       +=3D ixp4xx.o
 obj-$(CONFIG_MTD_IXP2000)      +=3D ixp2000.o
-obj-$(CONFIG_MTD_WRSBC8260)    +=3D wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)       +=3D dmv182.o
 obj-$(CONFIG_MTD_PLATRAM)      +=3D plat-ram.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR) +=3D intel_vr_nor.o

I've amended the patch and pushed to l2-mtd.git tree, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-9/21tXQP4WOSLufDLbyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJP7WdkAAoJECmIfjd9wqK0DXgP/RoqujuPnNCIvySfVwtk8vcN
5k5NAHplUjNsr+3ZfCA7kenCesPZcELtdIcRIoiuEg0FFEyWuZ7h4UUeCRy57MLZ
HvaWfyLfWn+hVaBhDhVtZ7gqTRTKn0VLjuXeWjiaqn05zTAdOfMLAtmaREIpsVr+
Zs7OisWrOcndbLmAOmMtz6weTti2j+E0uK2C5VHZvil3igkJHHLfbk4fjqRkuT/c
ZJhpt03N323Y5BDnej4dqJ1OGTiLj0LuXoWNVtKbgoNXDRFpFhwSWTXRNzkx1o9s
ocBPBFlsxYiBvEPoZ2E5bznn2s8pJgR53kEnA/ODFht7fV+qZvzRsdoIv2GWMhTU
Leu3EQIkglok+PgBmH6qI6lTT0b1UT9jUItoZctFTjAC34ZRSIckMeUpKeGZw27u
Tt8TMxEa3+tLKMJHUC3fod5hd3D+VUvLDdfA7o5ZzfJ8rFpCC+G4KtmggacwC5A5
NiR9A5y2OuD3tbDRnlUdRJIp3xT3ujXXN01xjfuG9JK1F7IV68EePugylr8+DgZe
xNjJ3ck46Qac6UrzOgVc7tQ1EQ/fhNOPQsYgEzREhXg+fge73iz/zSiO4yY4V6c2
sPx0A3CAh43iSFtSXc2oFbkFONy8yRwKJyygv0UsYcESW/H0/eAwC9thJkWUU3so
SwurOYou0y+83WN3EoKB
=hFc/
-----END PGP SIGNATURE-----

--=-9/21tXQP4WOSLufDLbyO--
