Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D144B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 19:30:38 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1DCF0DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:30:38 +1000 (EST)
Date: Thu, 20 Aug 2009 02:30:47 -0700 (PDT)
Message-Id: <20090820.023047.86718643.davem@davemloft.net>
To: michal.simek@petalogix.com
Subject: Re: [PATCH] [V2] net: add Xilinx emac lite device driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A8D1750.4000804@petalogix.com>
References: <20090819122920.37EE21728051@mail110-dub.bigfish.com>
	<20090820.022536.264747725.davem@davemloft.net>
	<4A8D1750.4000804@petalogix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sadanan@xilinx.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, john.linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Simek <michal.simek@petalogix.com>
Date: Thu, 20 Aug 2009 11:28:48 +0200

> There were one bug with spinlock which John L fixed but not send to
> mainling list. :-(
> He wanted to create new v3 version. :-(.
> When he wake up, he send you that bug fix or v3 version with it.

Send a new version, I'll revert V2 from my tree as I didn't push it
out yet.
