Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A684DB7D24
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 13:45:09 +1000 (EST)
Date: Wed, 26 May 2010 20:45:17 -0700 (PDT)
Message-Id: <20100526.204517.35032653.davem@davemloft.net>
To: john.linn@xilinx.com
Subject: Re: [PATCH 2/2] net: ll_temac: fix checksum offload logic
From: David Miller <davem@davemloft.net>
In-Reply-To: <0690e798-1e5e-4416-90dc-04a9df16600f@SG2EHSMHS005.ehs.local>
References: <1274894959-27473-1-git-send-email-john.linn@xilinx.com>
	<0690e798-1e5e-4416-90dc-04a9df16600f@SG2EHSMHS005.ehs.local>
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

aFrom: John Linn <john.linn@xilinx.com>
Date: Wed, 26 May 2010 11:29:19 -0600

> The current checksum offload code does not work and this corrects
> that functionality. It also updates the interrupt coallescing
> initialization so than there are fewer interrupts and performance
> is increased.
> 
> Signed-off-by: Brian Hill <brian.hill@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Applied, although I changed "temac_features" to be explicitly
"unsigned int" instead of just plain "unsigned"
