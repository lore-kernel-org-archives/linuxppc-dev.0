Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28F111A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:13:49 +1000 (EST)
Message-ID: <1405980805.29414.25.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 3/7] powerpc/corenet: Create the dts components for
 the DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Shruti Kanetkar <Shruti@Freescale.com>
Date: Mon, 21 Jul 2014 17:13:25 -0500
In-Reply-To: <1405541831-1277-3-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-3-git-send-email-Shruti@Freescale.com>
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

On Wed, 2014-07-16 at 15:17 -0500, Shruti Kanetkar wrote:
> '761743e net/fsl_pq_mdio: add support for the Fman 1G MDIO controller'
> introduced driver support for the FMan MDIO controller. Now add the DT
> description for the MDIO controller from all FMan revisions
> 
> Note that the FMan v3 MDIO controller is not compatible with prior revisions
> of FMan (also QE and eTSEC) however, we're adding basic DT support here
> 
> Based on prior work by Andy Fleming <afleming@gmail.com>
> 
> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
> ---

What changed in v2?

> +fman@500000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";

NACK as previously discussed.

Please work with Igal Liberman who has been working on the fman binding.

Or, if you want to make a case for this being truly independent of the
rest of FMan, make it truly independent.  But is it indepedent?  If I
write to FM_RSTC[RFM], will the MDIO be reset as well?

-Scott
