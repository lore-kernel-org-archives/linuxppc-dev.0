Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB7A51A0612
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 11:28:58 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0126.outbound.protection.outlook.com [207.46.100.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45C5C14014D
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 11:28:57 +1100 (AEDT)
Message-ID: <1417566527.15957.225.camel@freescale.com>
Subject: Re: [PATCH v3 1/4] powerpc/mpc85xx: Create dts components for the
 FSL QorIQ DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 2 Dec 2014 18:28:47 -0600
In-Reply-To: <1417428135-12895-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1417428135-12895-1-git-send-email-Emilian.Medve@Freescale.com>
 <1417428135-12895-2-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-01 at 04:02 -0600, Emil Medve wrote:
> +bman: bman@31a000 {
> +	compatible = "fsl,bman";
> +	reg = <0x31a000 0x1000>;
> +	interrupts = <16 2 1 2>;
> +	fsl,bman-portals = &bportals;
> +	memory-region = <&bman_fbpr>;

Shouldn't it be <&bportals>?

And I don't see fsl,bman-portals in the binding...

-Scott
