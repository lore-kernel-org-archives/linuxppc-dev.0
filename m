Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 43CCB67EB3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 23:51:32 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j74DxW5i020839
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Aug 2005 06:59:32 -0700 (MST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467302794005@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467302794005@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6A6E571F-AD8D-47FC-8AFA-298254340458@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 4 Aug 2005 08:51:33 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: Jiang Bo-r61859 <tanya.jiang@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Fix MPC8349 USB memory mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Oops, I'll forward this bug fix on.

- kumar

On Aug 4, 2005, at 3:47 AM, Li Yang-r58472 wrote:

> Hi,
>
> The memory mappings for MPC8349 USB MPH and DR modules were reversed.
>
> Signed-off-by: Li Yang <LeoLi@freescale.com>
> Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
>
> ---
>
> --- arch/ppc/syslib/mpc83xx_devices.c.orig    2005-08-04
> 16:37:20.000000000 +0800
> +++ arch/ppc/syslib/mpc83xx_devices.c    2005-08-04 16:38:25.000000000
> +0800
> @@ -191,8 +191,8 @@ struct platform_device ppc_sys_platform_
>          .num_resources     = 2,
>          .resource = (struct resource[]) {
>              {
> -                .start    = 0x22000,
> -                .end    = 0x22fff,
> +                .start    = 0x23000,
> +                .end    = 0x23fff,
>                  .flags    = IORESOURCE_MEM,
>              },
>              {
> @@ -208,8 +208,8 @@ struct platform_device ppc_sys_platform_
>          .num_resources     = 2,
>          .resource = (struct resource[]) {
>              {
> -                .start    = 0x23000,
> -                .end    = 0x23fff,
> +                .start    = 0x22000,
> +                .end    = 0x22fff,
>                  .flags    = IORESOURCE_MEM,
>              },
>              {
>
> --
> Leo Li
> Freescale Semiconductor
>
> LeoLi@freescale.com
>
>
