Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id B38CF2C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 04:13:12 +1100 (EST)
Date: Sun, 24 Feb 2013 12:04:58 -0500 (EST)
Message-Id: <20130224.120458.1711395595508489332.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Subject: Re: [PATCH net] gianfar: fix compile fail for NET_POLL=y due to
 struct packing
From: David Miller <davem@davemloft.net>
In-Reply-To: <1361720311-13267-1-git-send-email-paul.gortmaker@windriver.com>
References: <1361717023.16950.12.camel@pasglop>
 <1361720311-13267-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jianhua.xie@freescale.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, claudiu.manoil@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 24 Feb 2013 10:38:31 -0500

> Commit ee873fda3bec7c668407b837fc5519eb961fcd37 ("gianfar: Pack struct
> gfar_priv_grp into three cachelines") moved the irq number and names
> off into a separate struct and created accessors for them.  However
> it was never tested with NET_POLL enabled, and so some conversions
> that were simply overlooked went undetected until now.
> 
> Make the netpoll ones also use the gfar_irq() accessors.
> 
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Claudiu Manoil <claudiu.manoil@freescale.com>
> Cc: Jianhua Xie <jianhua.xie@freescale.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.
