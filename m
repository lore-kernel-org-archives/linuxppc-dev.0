Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AC311A1A6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 06:00:01 +1000 (AEST)
Message-ID: <1438286389.2993.365.camel@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpc85xx: Create dts components for the
 FSL QorIQ DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <madalin.bucur@freescale.com>, <linux-kernel@vger.kernel.org>
Date: Thu, 30 Jul 2015 14:59:49 -0500
In-Reply-To: <1438230764-10951-1-git-send-email-igal.liberman@freescale.com>
References: <1438230764-10951-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-30 at 07:32 +0300, Igal.Liberman wrote:
> +fman0:  fman@400000{
> +     #address-cells = <1>;
> +     #size-cells = <1>;
> +     cell-index = <0>;
> +     compatible = "fsl,fman";
> +     ranges = <0 0x400000 0x100000>;
> +     reg = <0x400000 0x100000>;
> +     interrupts = <96 2 0 0>, <16 2 1 1>;
> +     clocks = <&clockgen 3 0>;
> +     clock-names = "fm0clk";

clock-names should be "fmanclk" as per the binding.  And why would you want 
the driver to have to encode the fman index into the name in order to look 
the clock up by name?

-Scott
