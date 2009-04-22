Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6CA1EDDF77
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 17:47:02 +1000 (EST)
Date: Wed, 22 Apr 2009 00:46:53 -0700 (PDT)
Message-Id: <20090422.004653.250792561.davem@davemloft.net>
To: leoli@freescale.com
Subject: Re: [PATCH] [net, 83xx] ucc_geth.c: Fix upsmr setting in RMII mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <2a27d3730904210351s870f015gb896a4b874b3024b@mail.gmail.com>
References: <49ED859B.30904@denx.de>
	<2a27d3730904210351s870f015gb896a4b874b3024b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: gridish@freescale.com, netdev@vger.kernel.org, hs@denx.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>
Date: Tue, 21 Apr 2009 18:51:11 +0800

> On Tue, Apr 21, 2009 at 4:36 PM, Heiko Schocher <hs@denx.de> wrote:
>> If using the UCC on a MPC8360 in RMII mode, don;t set
>> UCC_GETH_UPSMR_RPM bit in the upsmr register.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> Acked-by: Li Yang <leoli@freescale.com>

Applied, thanks.
