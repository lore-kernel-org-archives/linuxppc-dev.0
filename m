Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id C4CE12C0354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 05:02:53 +1100 (EST)
Date: Wed, 09 Oct 2013 14:02:51 -0400 (EDT)
Message-Id: <20131009.140251.1669096107735357420.davem@davemloft.net>
To: claudiu.manoil@freescale.com
Subject: Re: [PATCH 2/3] gianfar: Use mpc85xx support for errata detection
From: David Miller <davem@davemloft.net>
In-Reply-To: <1381339242-32030-2-git-send-email-claudiu.manoil@freescale.com>
References: <1381339242-32030-1-git-send-email-claudiu.manoil@freescale.com>
 <1381339242-32030-2-git-send-email-claudiu.manoil@freescale.com>
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
Date: Wed, 9 Oct 2013 20:20:41 +0300

> Use the macros and defines from mpc85xx.h to simplify
> and prevent errors in identifying a mpc85xx based SoC
> for errata detection.
> This should help enabling (and identifying) workarounds
> for various mpc85xx based chips and revisions.
> For instance, express MPC8548 Rev.2 as:
> (SVR_SOC_VER(svr) == SVR_8548) && (SVR_REV(svr) == 0x20)
> instead of:
> (pvr == 0x80210020 && mod == 0x8030 && rev == 0x0020)
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>

Applied.
