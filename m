Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 80835DE640
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 13:49:15 +1000 (EST)
Date: Tue, 26 May 2009 20:49:11 -0700 (PDT)
Message-Id: <20090526.204911.75347876.davem@davemloft.net>
To: kexin.hao@windriver.com
Subject: Re: [PATCH] net/ucc_geth: allow to set mac address on running device
From: David Miller <davem@davemloft.net>
In-Reply-To: <1243388936.13410.4.camel@kevin>
References: <1243388936.13410.4.camel@kevin>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kevin Hao <kexin.hao@windriver.com>
Date: Wed, 27 May 2009 09:48:56 +0800

> Inspired by the patch for 8139too (bda6a15a).
> 
> Currently we can't set mac address on a running ucc_geth device.
> But this is needed when you use this device as a bonding slave in
> bonding device in balance-alb mode. So add this feature for ucc_geth
> device.
> 
> Signed-off-by: Kevin Hao <kexin.hao@windriver.com>

Applied to net-next-2.6, thanks.
