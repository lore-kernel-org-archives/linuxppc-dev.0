Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E49BB6FD3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 05:23:35 +1000 (EST)
Date: Fri, 17 Jun 2011 15:21:23 -0400 (EDT)
Message-Id: <20110617.152123.620960460056800771.davem@davemloft.net>
To: holger.brunck@keymile.com
Subject: Re: [PATCH] fs_enet: fix freescale FCC ethernet dp buffer alignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <1308299439-5975-1-git-send-email-holger.brunck@keymile.com>
References: <1308299439-5975-1-git-send-email-holger.brunck@keymile.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: clive.stubbings@xentech.co.uk, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Holger Brunck <holger.brunck@keymile.com>
Date: Fri, 17 Jun 2011 10:30:39 +0200

> From: Clive Stubbings <clive.stubbings@xentech.co.uk>
> 
> The RIPTR and TIPTR  (receive/transmit internal temporary data pointer),
> used by microcode as a temporary buffer for data, must be 32-byte aligned
> according to the RM for MPC8247.
> 
> Tested on mgcoge.
> 
> Signed-off-by: Clive Stubbings <clive.stubbings@xentech.co.uk>
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
> cc: Vitaly Bordug <vbordug@ru.mvista.com>
> cc: netdev@vger.kernel.org

Applied, thanks.
