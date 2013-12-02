Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x233.google.com (mail-pb0-x233.google.com
 [IPv6:2607:f8b0:400e:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D7C32C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 03:04:59 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id up15so19382415pbc.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Dec 2013 08:04:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Dec 2013 08:04:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
Message-ID: <20131202160453.GA32723@roeck-us.net>
References: <20131130154540.E83D743E15@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20131130154540.E83D743E15@localhost.localdomain>
Cc: scottwood@freescale.com, Wim Van Sebroeck <wim@iguana.be>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 30, 2013 at 04:45:40PM +0100, Christophe Leroy wrote:
> MPC8xx watchdog is enabled at startup by HW.
> If the bootloader disables it, it cannot be reenabled.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
