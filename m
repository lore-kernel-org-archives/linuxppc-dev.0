Return-Path: <tnt@246tNt.com>
Received: from outmx030.isp.belgacom.be (outmx030.isp.belgacom.be
	[195.238.6.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5895DDECD
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 21:25:33 +1100 (EST)
Received: from outmx030.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx030.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l25APMS0031869
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 11:25:22 +0100
Message-ID: <45EBEFEE.9030309@246tNt.com>
Date: Mon, 05 Mar 2007 11:24:46 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH alternative] lite5200(b) support for i2c
References: <20070302104718.GU4397@moe.telargo.com>
	<20070305100802.GV4397@moe.telargo.com>
In-Reply-To: <20070305100802.GV4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> Add fsl-i2c to lite5200 i2c nodes in device tree, and enable FSL_SOC.
>
> Tested to work with built-in eeprom on lite5200b.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
> This patch obsoletes the previous one, and is shorter too :-)
>
>
>  arch/powerpc/Kconfig                |    1 +
>  arch/powerpc/boot/dts/lite5200.dts  |    6 ++++--
>  arch/powerpc/boot/dts/lite5200b.dts |    6 ++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> Index: grant.git/arch/powerpc/Kconfig
> ===================================================================
> --- grant.git.orig/arch/powerpc/Kconfig
> +++ grant.git/arch/powerpc/Kconfig
> @@ -128,6 +128,7 @@ config CLASSIC32
>  	bool "52xx/6xx/7xx/74xx"
>  	select PPC_FPU
>  	select 6xx
> +	select FSL_SOC
>  	help
>  	  There are four families of PowerPC chips supported.  The more common
>  	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
>
>   
I would put the select FSL_SOC under the  PPC_MPC52xx symbol and not the
CLASSIC32 one.
Otherwise, looks good.

    Sylvain
