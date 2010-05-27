Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 86F3EB7D1A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 13:44:39 +1000 (EST)
Date: Wed, 26 May 2010 20:44:46 -0700 (PDT)
Message-Id: <20100526.204446.229736739.davem@davemloft.net>
To: john.linn@xilinx.com
Subject: Re: [PATCH 1/2] net: ll_temac: fix interrupt bug when interrupt 0
	is used
From: David Miller <davem@davemloft.net>
In-Reply-To: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
References: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, brian.hill@xilinx.com,
	michal.simek@petalogix.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Linn <john.linn@xilinx.com>
Date: Wed, 26 May 2010 11:29:18 -0600

> The code is not checking the interrupt for DMA correctly so that an
> interrupt number of 0 will cause a false error.
> 
> Signed-off-by: Brian Hill <brian.hill@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Applied.
