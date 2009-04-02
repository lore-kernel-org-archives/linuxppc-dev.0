Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E00C8DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 19:26:29 +1100 (EST)
Date: Thu, 02 Apr 2009 01:26:18 -0700 (PDT)
Message-Id: <20090402.012618.151021224.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Pass proper device to DMA routines,
	otherwise oops happens
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090331185837.GA22545@oksana.dev.rtsoft.ru>
References: <20090331185837.GA22545@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, afleming@freescale.com,
	Joakim.Tjernlund@transmode.se, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 31 Mar 2009 22:58:37 +0400

> The driver should pass a device that actually specifies internal DMA
> ops, but currently it passes netdev's device, which is wrong and that
> causes following oops:
 ...
> Fix this by passing of_device's device that specifies DMA ops in its
> archdata.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks.
