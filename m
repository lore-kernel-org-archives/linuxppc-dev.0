Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 133802C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Mar 2014 07:41:47 +1100 (EST)
Date: Fri, 07 Mar 2014 15:41:42 -0500 (EST)
Message-Id: <20140307.154142.488351276799532264.davem@davemloft.net>
To: alistair@popple.id.au
Subject: Re: [PATCH 2/5] IBM Akebono: Add support for a new PHY interface
 to the IBM emac driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1394077948-8395-3-git-send-email-alistair@popple.id.au>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
 <1394077948-8395-3-git-send-email-alistair@popple.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>
Date: Thu,  6 Mar 2014 14:52:25 +1100

> +	out_be32(dev->reg, in_be32(dev->reg) | WKUP_ETH_RGMIIEN
> +		 | WKUP_ETH_TX_OE | WKUP_ETH_RX_IE);

When an expression spans multiple lines, the lines should end with
operators rather than begin with them.

Also, it would be easier to read this call if parenthesis were put
around the third argument and then indented to match, f.e.:

	out_be32(dev->reg, (in_be32(dev->reg) | WKUP_ETH_RGMIIEN |
			    WKUP_ETH_TX_OE | WKUP_ETH_RX_IE));
