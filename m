Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 380B4DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:04:59 +1100 (EST)
Date: Mon, 13 Oct 2008 20:05:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <20081013045116.GA11637@ime.usp.br>
Message-ID: <Pine.LNX.4.64.0810132003350.9041@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Oct 2008, Rog=E9rio Brito wrote:

> The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
> Randomization" option enabled.
>=20
> Since some of these machines are facing the internet, it helps to have
> heap randomization enabled. This patch enables it.

Same as the previous patch - this is one of options, that users select=20
according to their needs. If any specific distribution enables this option=
=20
by default in their kernels, they can do this too, don't think this is=20
critical enough to patch the defconfig.

Thanks
Guennadi

>=20
>=20
> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>=20
> ---
>=20
> --- linux/arch/powerpc/configs/linkstation_defconfig.old=092008-10-13 00:=
33:00.000000000 -0300
> +++ linux/arch/powerpc/configs/linkstation_defconfig=092008-10-13 01:11:2=
8.000000000 -0300
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.27-rc4
> -# Thu Aug 21 00:52:05 2008
> +# Linux kernel version: 2.6.27
> +# Mon Oct 13 01:11:21 2008
>  #
>  # CONFIG_PPC64 is not set
> =20
> @@ -101,7 +101,7 @@ CONFIG_HOTPLUG=3Dy
>  CONFIG_PRINTK=3Dy
>  CONFIG_BUG=3Dy
>  CONFIG_ELF_CORE=3Dy
> -CONFIG_COMPAT_BRK=3Dy
> +# CONFIG_COMPAT_BRK is not set
>  CONFIG_BASE_FULL=3Dy
>  CONFIG_FUTEX=3Dy
>  CONFIG_ANON_INODES=3Dy
> @@ -1211,7 +1211,6 @@ CONFIG_USB_STORAGE=3Dm
>  # CONFIG_USB_STORAGE_ALAUDA is not set
>  # CONFIG_USB_STORAGE_ONETOUCH is not set
>  # CONFIG_USB_STORAGE_KARMA is not set
> -# CONFIG_USB_STORAGE_SIERRA is not set
>  # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
>  # CONFIG_USB_LIBUSUAL is not set
> =20
>=20
> --=20
> Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
> http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
> Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
