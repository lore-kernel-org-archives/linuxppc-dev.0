Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 402532C010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 04:51:01 +1000 (EST)
Date: Mon, 30 Sep 2013 14:50:56 -0400 (EDT)
Message-Id: <20130930.145056.669909746688674911.davem@davemloft.net>
To: aida.mynzhasova@skitlab.ru
Subject: Re: [PATCH v2] powerpc/83xx: gianfar_ptp: select 1588 clock source
 through dts file
From: David Miller <davem@davemloft.net>
In-Reply-To: <1380093863-5388-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1380093863-5388-1-git-send-email-aida.mynzhasova@skitlab.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree@vger.kernel.org, richardcochran@gmail.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Date: Wed, 25 Sep 2013 11:24:23 +0400

> Currently IEEE 1588 timer reference clock source is determined through
> hard-coded value in gianfar_ptp driver. This patch allows to select ptp
> clock source by means of device tree file node.
> 
> For instance:
> 
> 	fsl,cksel = <0>;
> 
> for using external (TSEC_TMR_CLK input) high precision timer
> reference clock.
> 
> Other acceptable values:
> 
> 	<1> : eTSEC system clock
> 	<2> : eTSEC1 transmit clock
> 	<3> : RTC clock input
> 
> When this attribute isn't used, eTSEC system clock will serve as
> IEEE 1588 timer reference clock.
> 
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>

Applied, thanks.
