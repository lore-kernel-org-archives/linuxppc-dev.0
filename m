Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94FDCB7BB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 10:51:49 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3DDB8DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 10:51:48 +1000 (EST)
Date: Tue, 01 Sep 2009 17:51:58 -0700 (PDT)
Message-Id: <20090901.175158.133228373.davem@davemloft.net>
To: michal.simek@petalogix.com
Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A9BCDB4.8040406@petalogix.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
	<20090820.025226.26907868.davem@davemloft.net>
	<4A9BCDB4.8040406@petalogix.com>
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
Date: Mon, 31 Aug 2009 15:18:44 +0200

> I see that John's patch has wrong file permission
> -rwxr-xr-x 	xilinx_emaclite.c
 ...
> should be 644.
> 
> Please fix it in your repo.

Done, thanks!
