Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CC45C67E8D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Aug 2005 05:32:24 +1000 (EST)
Date: Sat, 13 Aug 2005 12:32:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20050813193220.GA19431@gate.ebshome.net>
References: <1123284390.27734.19.camel@rhino.az.mvista.com>
	<20050808164457.C9951@cox.net>
	<1123792927.27880.34.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123792927.27880.34.camel@rhino.az.mvista.com>
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

On Thu, Aug 11, 2005 at 01:42:07PM -0700, Wade Farnsworth wrote:

[snip]

> diff -upr linux-2.6/include/asm-ppc/ibm_ocp.h linux-2.6-dev/include/asm-ppc/ibm_ocp.h
> --- linux-2.6/include/asm-ppc/ibm_ocp.h	2005-08-11 13:30:02.000000000 -0700
> +++ linux-2.6-dev/include/asm-ppc/ibm_ocp.h	2005-08-11 13:12:34.000000000 -0700
> @@ -67,6 +67,7 @@ struct ocp_func_emac_data {
>  	int	phy_mode;	/* PHY type or configurable mode */
>  	u8	mac_addr[6];	/* EMAC mac address */
>  	u32	phy_map;	/* EMAC phy map */
> +	u32	phy_feat_exc;	/* Excluded PHY features */
>  };
>  
>  /* Sysfs support */

Please, update OCP_SYSFS_EMAC_DATA() macro as well.

-- 
Eugene
