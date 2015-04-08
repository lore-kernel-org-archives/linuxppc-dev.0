Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0D3B1A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 07:12:07 +1000 (AEST)
Message-ID: <1428527516.22867.509.camel@freescale.com>
Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Wed, 8 Apr 2015 16:11:56 -0500
In-Reply-To: <1428479031-26597-1-git-send-email-igal.liberman@freescale.com>
References: <1428479031-26597-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-08 at 10:43 +0300, Igal.Liberman wrote:
> @@ -76,6 +77,52 @@ Required properties:
>  
>  Recommended properties:
>  - clocks: Should be the phandle of input parent clock
> +	For "fsl,fman-clk-mux" clock there are several options for parent
> +	clock (clock provider), the parent is determined according to the
> +	Reset Configuration Word of the specific device:
> +		* P2041, P3041:
> +			* 0 - equal to platform PLL divided by 2
> +			* 1 - equal to PLL2 divided by 2
> +		* P4080 (Both FMans):
> +			* 0 - equal to platform PLL divided by 2
> +			* 1 - equal to PLL3 divided by 2
...


Again, the clock specifier format is determined by the clock provider,
not the clock consumer.

-Scott
