Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq1BH6WR2zDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 11:16:23 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id ib6so2029896pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 18:16:23 -0700 (PDT)
Date: Wed, 13 Jul 2016 09:16:09 +0800
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/3] powerpc: tweak the kernel options for CRASH_DUMP
 and RELOCATABLE
Message-ID: <20160713011609.GM17403@pek-khao-d1>
References: <1468372373-6346-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
In-Reply-To: <1468372373-6346-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please ignore this. Forgot the CC list.

Thanks,
Kevin

On Wed, Jul 13, 2016 at 09:12:53AM +0800, Kevin Hao wrote:
> v2:
> Compare to v1 [1], the main differences are:
>  - Still automatically select RELOCATABLE when CRASH_DUMP is enabled.
>  - Add a new patch to kill RELOCATABLE_PPC32.
>=20
> v1:
> The first patch fixes a build error when CRASH_DUMP=3Dy && ADVANCED_OPTIO=
NS=3Dn
> for ppc32. The second does some cleanup for RELOCATABLE option.
>=20
> Kevin Hao (3):
>   powerpc32: booke: fix the build error when CRASH_DUMP is enabled
>   powerpc: merge the RELOCATABLE config entries for ppc32 and ppc64
>   powerpc32: kill RELOCATABLE_PPC32
>=20
>  arch/powerpc/Kconfig              | 61 +++++++++++++++------------------=
------
>  arch/powerpc/include/asm/page.h   |  6 ++--
>  arch/powerpc/kernel/Makefile      |  3 +-
>  arch/powerpc/kernel/vmlinux.lds.S |  2 +-
>  arch/powerpc/mm/init_32.c         |  2 +-
>  5 files changed, 29 insertions(+), 45 deletions(-)
>=20
> [1] http://linuxppc-dev.ozlabs.narkive.com/fKHcSZbu/patch-0-2-powerpc-twe=
ak-the-kernel-options-for-crash-dump-and-relocatable
> --=20
> 2.8.1
>=20

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXhZZZAAoJEJNY7TDerrFxIzIH/3QbKEWYk3G5bZdHzXiIcH0c
BZE1wVuREcORxPrpnoohXRw+CaobJw+teFGYsysn/6uY4pxrA3GmpRjPJxFmocJ/
vzYmopBzVMq2WfEOdvqTC5In1WBH7xfcRqVVYlaRJ97nF/wEWyBatTKBuGpiGM7N
4GWwAaoaJVgXt1TdZV44StrYjJyueg+DHANbek1oBsIQMxYm+n8a6XG8piOUSOFP
0c2wbTFgCsDTROPngy8VsVpXjQ9ledeqYGpVVmkj25GYYCMv7PctkCFGFVwhFuki
lx9SqYTcZlR6H6dZ/VRO1Z+s3Ryt89iGRRtNCTxaKILKleYrOoSPH/i5Tn8pa7M=
=MW37
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
