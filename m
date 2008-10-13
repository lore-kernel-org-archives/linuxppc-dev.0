Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DD81BDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:03:12 +1100 (EST)
Date: Mon, 13 Oct 2008 20:03:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [PATCH] powerpc: compile kernel for linkstations optimized for
	size
In-Reply-To: <20081013040703.GA11059@ime.usp.br>
Message-ID: <Pine.LNX.4.64.0810131959140.9041@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
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

> From: Rog=E9rio Brito <rbrito@ime.usp.br>
>=20
> Since Linkstations and Kuroboxes often have *very* little memory (as
> they are embedded systems), it is desirable to get their kernels
> compiled optimized for size.
>=20
> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>
>=20
> ---
>=20
> I have been using kernels optimized for size on my Kurobox (standard)
> for many different releases and I have experienced no problem with this
> option enabled. Thus, this patch.

The comment for this option says: "watch out for broken compilers," if=20
this doesn't hold any more, it should be remove, if it still holds, I=20
wouldn't turn this on by default, as I don't think we can test all=20
possible (cross- or native-) compilers users might want to use. In any=20
case this is one of options that users can select themselves, if it suits=
=20
them. Also I don't think your CC list is correct, you wanted to send this=
=20
to the powerpc list and one of powerpc / subarch maintainer.

Thanks
Guennadi

>=20
> --- linux/arch/powerpc/configs/linkstation_defconfig.old=092008-10-13 00:=
33:00.000000000 -0300
> +++ linux/arch/powerpc/configs/linkstation_defconfig=092008-10-13 00:38:5=
8.000000000 -0300
> @@ -90,7 +90,7 @@ CONFIG_NAMESPACES=3Dy
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_INITRAMFS_SOURCE=3D""
> -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>  CONFIG_SYSCTL=3Dy
>  # CONFIG_EMBEDDED is not set
>  CONFIG_SYSCTL_SYSCALL=3Dy
>=20
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
