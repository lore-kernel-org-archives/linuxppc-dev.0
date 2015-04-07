Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0119.outbound.protection.outlook.com [65.55.169.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B69741A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 09:45:42 +1000 (AEST)
Message-ID: <1428450326.22867.486.camel@freescale.com>
Subject: Re: [PATCH 3/4] powerpc/fsl-booke: Add T1024 RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Tue, 7 Apr 2015 18:45:26 -0500
In-Reply-To: <1428057350-33553-3-git-send-email-Shengzhou.Liu@freescale.com>
References: <1428057350-33553-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1428057350-33553-3-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 18:35 +0800, Shengzhou Liu wrote:

> +		board-control@2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,t1024-cpld", "fsl,deepsleep-cpld";

No "fsl,deepsleep-cpld".  Just have the driver recognize the compatibles
for the chips that have deep sleep.

Even if you were to do this, it would need to be documented in a
binding, and you'd need to be more specific about what CPLD family
you're talking about.

> +		tdma: ucc@2000 {
> +			compatible = "fsl,ucc-tdm";
> +			rx-clock-name = "clk8";
> +			tx-clock-name = "clk9";
> +			fsl,rx-sync-clock = "rsync_pin";
> +			fsl,tx-sync-clock = "tsync_pin";
> +			fsl,tx-timeslot = <0xfffffffe>;
> +			fsl,rx-timeslot = <0xfffffffe>;
> +			fsl,tdm-framer-type = "e1";
> +			fsl,tdm-mode = "normal";
> +			fsl,tdm-id = <0>;
> +			fsl,siram-entry-id = <0>;
> +		};

Binding?

-Scott
