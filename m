Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B3D45B7D40
	for <linuxppc-dev@ozlabs.org>; Sat, 29 May 2010 17:16:28 +1000 (EST)
Date: Sat, 29 May 2010 00:16:36 -0700 (PDT)
Message-Id: <20100529.001636.42779529.davem@davemloft.net>
To: mware@elphinstone.net
Subject: Re: [PATCH] fs_enet: Adjust BDs after tx error
From: David Miller <davem@davemloft.net>
In-Reply-To: <4BFDC6EC.9090804@elphinstone.net>
References: <4BFDC6EC.9090804@elphinstone.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Ware <mware@elphinstone.net>
Date: Thu, 27 May 2010 11:12:12 +1000

> This patch fixes an occasional transmit lockup in the mac-fcc which
> occurs after a tx error.  The test scenario had the local port set
> to autoneg and the other end fixed at 100FD, resulting in a large
> number of late collisions.
> 
> According to the MPC8280RM 30.10.1.3 (also 8272RM 29.10.1.3), after
> a tx error occurs, TBPTR may sometimes point beyond BDs still marked
> as ready.  This patch walks back through the BDs and points TBPTR to
> the earliest one marked as ready.
> 
> Tested on a custom board with a MPC8280.
> 
> Signed-off-by: Mark Ware <mware@elphinstone.net>

Applied, thanks.
