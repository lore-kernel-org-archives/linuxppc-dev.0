Return-Path: <wimvs@spo001.leaseweb.com>
Received: from spo001.leaseweb.com (ns1.pc-advies.be [83.149.101.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7FE3C2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 07:18:30 +1100 (EST)
Date: Mon, 24 Feb 2014 20:51:27 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
Message-ID: <20140224195127.GA20712@spo001.leaseweb.com>
References: <20131130154540.E83D743E15@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20131130154540.E83D743E15@localhost.localdomain>
Sender: <wimvs@spo001.leaseweb.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

> MPC8xx watchdog is enabled at startup by HW.
> If the bootloader disables it, it cannot be reenabled.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> diff -ur a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> --- a/drivers/watchdog/mpc8xxx_wdt.c	2013-05-11 22:57:46.000000000 +0200
> +++ b/drivers/watchdog/mpc8xxx_wdt.c	2013-08-08 02:12:15.000000000 +0200
> @@ -273,6 +310,7 @@
>  		.compatible = "fsl,mpc823-wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
> +			.hw_enabled = true,
>  		},
>  	},
>  	{},
> 
> ---
> Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
> http://www.avast.com
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
