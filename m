Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1DC5EB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 19:25:28 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D5541DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:25:27 +1000 (EST)
Date: Thu, 20 Aug 2009 02:25:36 -0700 (PDT)
Message-Id: <20090820.022536.264747725.davem@davemloft.net>
To: john.linn@xilinx.com
Subject: Re: [PATCH] [V2] net: add Xilinx emac lite device driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090819122920.37EE21728051@mail110-dub.bigfish.com>
References: <20090819122920.37EE21728051@mail110-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: michal.simek@petalogix.com, netdev@vger.kernel.org, sadanan@xilinx.com,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Linn <john.linn@xilinx.com>
Date: Wed, 19 Aug 2009 06:29:11 -0600

> This patch adds support for the Xilinx Ethernet Lite device.  The
> soft logic core from Xilinx is typically used on Virtex and Spartan
> designs attached to either a PowerPC or a Microblaze processor.
> 
> Signed-off-by: Sadanand M <sadanan@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good, applied to net-next-2.6, thanks!
