Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7C41DDDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 21:23:23 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2DANJss010062
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 03:23:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2DANIuV017398
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 05:23:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] powerpc: automatically select QE options
Date: Tue, 13 Mar 2007 18:24:45 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DAF26@zch01exm26.fsl.freescale.net>
In-Reply-To: <1173732027723-git-send-email-timur@freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>, <linuxppc-dev@ozlabs.org>,
	<galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur,

ACK on removing choices for UCC_FAST and UCC_SLOW. =20

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6dfbd52..54dd66c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -396,8 +396,6 @@ endchoice
>=20
>  config QUICC_ENGINE
>  	bool
> -	depends on PPC_MPC836x || PPC_MPC832x
> -	default y
>  	help
>  	  The QUICC Engine (QE) is a new generation of communications
>  	  coprocessors on Freescale embedded CPUs (akin to CPM in older
chips).

But I'd prefer QUICC_ENGINE option to depend on chip models rather than
boards.  Also the comment doesn't reflect this change.

[snip]

- Leo
