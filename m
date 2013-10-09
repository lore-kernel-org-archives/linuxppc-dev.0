Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 20B562C03A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 05:02:59 +1100 (EST)
Date: Wed, 09 Oct 2013 14:02:56 -0400 (EDT)
Message-Id: <20131009.140256.1615997457968740448.davem@davemloft.net>
To: claudiu.manoil@freescale.com
Subject: Re: [PATCH 3/3] gianfar: Enable eTSEC-20 erratum w/a for P2020 Rev1
From: David Miller <davem@davemloft.net>
In-Reply-To: <1381339242-32030-3-git-send-email-claudiu.manoil@freescale.com>
References: <1381339242-32030-1-git-send-email-claudiu.manoil@freescale.com>
 <1381339242-32030-3-git-send-email-claudiu.manoil@freescale.com>
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
Date: Wed, 9 Oct 2013 20:20:42 +0300

> Enable workaround for P2020/P2010 erratum eTSEC 20,
> "Excess delays when transmitting TOE=1 large frames".
> The impact is that frames lager than 2500-bytes for which
> TOE (i.e. TCP/IP hw accelerations like Tx csum) is enabled
> may see excess delay before start of transmission.
> This erratum was fixed in Rev 2.0.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>

Applied.
