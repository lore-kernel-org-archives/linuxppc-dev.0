Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCAB71A031F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 08:44:00 +1000 (AEST)
Message-ID: <1428533027.22867.517.camel@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 8 Apr 2015 17:43:47 -0500
In-Reply-To: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Yuantian.Tang@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-08 at 18:46 +0800, Shengzhou Liu wrote:
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t1023-clockgen", "fsl,qoriq-clockgen-2.0",
> +				   "fixed-clock";
> +		reg = <0xe1000 0x1000>;
> +		clock-output-names = "sysclk";
> +		#clock-cells = <0>;

Why aren't you using qoriq-clockgen2.dtsi?  Where is ranges?

We've been putting the sysclk in its own node, though even after reading
the discussion in http://patchwork.ozlabs.org/patch/274134/ and
http://patchwork.ozlabs.org/patch/290226/ I still don't know what was
wrong with the unified approach.


> +		data-only@0 {
> +			compatible = "fsl,qe-muram-data",
> +			"fsl,cpm-muram-data";
> +			reg = <0x0 0x6000>;

Whitespace.

-Scott
