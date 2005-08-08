Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id F3A3467E9C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 09:44:59 +1000 (EST)
Date: Mon, 8 Aug 2005 16:44:57 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20050808164457.C9951@cox.net>
References: <1123284390.27734.19.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123284390.27734.19.camel@rhino.az.mvista.com>;
	from wfarnsworth@mvista.com on Fri, Aug 05, 2005 at 04:26:30PM
	-0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add field to struct ocp_func_emac_data for
	platform-specific unsupported PHY features
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2005 at 04:26:30PM -0700, Wade Farnsworth wrote:
>  static int
> --- linux-2.6/include/asm-ppc/ibm_ocp.h	2005-08-03 13:34:08.000000000 -0700
> +++ linux-2.6-dev/include/asm-ppc/ibm_ocp.h	2005-08-02 10:49:42.000000000 -0700
> @@ -67,6 +67,7 @@ struct ocp_func_emac_data {
>  	int	phy_mode;	/* PHY type or configurable mode */
>  	u8	mac_addr[6];	/* EMAC mac address */
>  	u32	phy_map;	/* EMAC phy map */
> +	u32	feat_unsupp;	/* Unsupported phy features */

Could you update this field (and related usages) to be "phy_ftr_exc"?
For "Excluded phy features".  Eugene and I discussed this on IRC and
think it's a better name...for one it starts with the phy_ prefix like
other related phy data. Except for that, it's ready for upstream.

Thanks,
Matt
