Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 6351EDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:31:48 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/8][Version 2] MPC5121 clock driver
Date: Wed, 25 Jun 2008 08:31:34 +0200
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
	<1214342672-23536-2-git-send-email-jrigby@freescale.com>
	<1214342672-23536-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1214342672-23536-3-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806250831.34503.david.jander@protonic.nl>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 June 2008 23:24:26 John Rigby wrote:
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/clock.c

>[...]

> +static void ref_clk_calc(struct clk *clk)
> +{
> +	unsigned long rate;
> +
> +	rate = devtree_getfreq("bus-frequency");
> +	if (rate == 0) {
> +		printk(KERN_WARNING
> +			"No bus-frequency in dev tree using 66MHz\n");

Just nit-picking, but there should be a comma after "tree".

Greetings,

-- 
David Jander
Protonic Holland.
