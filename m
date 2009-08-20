Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3D8E8B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 19:52:17 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F363EDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:52:16 +1000 (EST)
Date: Thu, 20 Aug 2009 02:52:26 -0700 (PDT)
Message-Id: <20090820.025226.26907868.davem@davemloft.net>
To: john.linn@xilinx.com
Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
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
Date: Thu, 20 Aug 2009 03:49:51 -0600

> This patch adds support for the Xilinx Ethernet Lite device.  The
> soft logic core from Xilinx is typically used on Virtex and Spartan
> designs attached to either a PowerPC or a Microblaze processor.
> 
> Signed-off-by: Sadanand M <sadanan@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Applied, thanks.
