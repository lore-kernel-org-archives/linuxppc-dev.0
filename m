Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E8892C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 11:21:29 +1100 (EST)
Date: Tue, 7 Jan 2014 18:21:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: tang yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [v7] clk: corenet: Adds the clock binding
Message-ID: <20140108002115.GA19801@home.buserror.net>
References: <1384938289-24713-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1384938289-24713-1-git-send-email-Yuantian.Tang@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 05:04:49PM +0800, tang yuantian wrote:
> +Recommended properties:
> +- ranges: Allows valid translation between child's address space and
> +	parent's. Must be present if the device has sub-nodes.
> +- #address-cells: Specifies the number of cells used to represent
> +	physical base addresses.  Must be present if the device has
> +	sub-nodes and set to 1 if present
> +- #size-cells: Specifies the number of cells used to represent
> +	the size of an address. Must be present if the device has
> +	sub-nodes and set to 1 if present

Why are we specifying #address-cells/#size-cells here?

> +2. Clock Provider/Consumer Binding
> +
> +Most of the bindings are from the common clock binding[1].
> + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should include one of the following:
> +	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
> +    * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
> +    * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
> +    * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
> +	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0)
> +	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0)

Some of those lines use tabs and others spaces -- I can fix when applying.

-Scott
