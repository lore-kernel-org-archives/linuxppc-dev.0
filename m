Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 02B3A1A0B73
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 06:55:55 +1100 (AEDT)
Date: Fri, 04 Dec 2015 14:55:49 -0500 (EST)
Message-Id: <20151204.145549.859527220803940077.davem@davemloft.net>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 igal.liberman@freescale.com, ppc@mindchasers.com, joe@perches.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se,
 gregkh@linuxfoundation.org
Subject: Re: [net-next v5 2/8] dpaa_eth: add support for DPAA Ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449150589-26253-3-git-send-email-madalin.bucur@freescale.com>
References: <1449150589-26253-1-git-send-email-madalin.bucur@freescale.com>
 <1449150589-26253-3-git-send-email-madalin.bucur@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@freescale.com>
Date: Thu, 3 Dec 2015 15:49:43 +0200

> @@ -0,0 +1,22 @@
> +menuconfig FSL_DPAA_ETH
> +	tristate "DPAA Ethernet"
> +	depends on FSL_SOC && FSL_BMAN && FSL_QMAN && FSL_FMAN
> +	select PHYLIB
> +	select FSL_FMAN_MAC

I do not see the FSL_FMAN_MAC Kconfig symbol defined anywhere in the
tree.
