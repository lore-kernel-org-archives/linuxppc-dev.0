Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 1AB232C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 05:02:48 +1100 (EST)
Date: Wed, 09 Oct 2013 14:02:44 -0400 (EDT)
Message-Id: <20131009.140244.1085107412533674383.davem@davemloft.net>
To: claudiu.manoil@freescale.com
Subject: Re: [PATCH 1/3] gianfar: Enable eTSEC-A002 erratum w/a for all parts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1381339242-32030-1-git-send-email-claudiu.manoil@freescale.com>
References: <1381339242-32030-1-git-send-email-claudiu.manoil@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Claudiu Manoil <claudiu.manoil@freescale.com>
Date: Wed, 9 Oct 2013 20:20:40 +0300

> A002 is still in "no plans to fix" state, and applies to all
> the current P1/P2 parts as well, so it's resonable to enable
> its workaround by default, for all the soc's with etsec.
> The impact of not enabling this workaround for affected parts
> is that under certain conditons (runt frames or even frames
> with RX error detected at PHY level) during controller reset,
> the controller might fail to indicate Rx reset (GRS) completion.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>

Applied.
