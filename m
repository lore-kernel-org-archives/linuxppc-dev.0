Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E249DDF09
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 23:32:33 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890D839B4@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D839B4@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B27F0350-E5ED-48BF-9605-1E6BE29B9E36@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ucc_geth.c, make PHY device optional.
Date: Wed, 4 Jul 2007 15:32:20 +0200
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> How about separate autoneg to a property "dumb-phy", which  
> indicates the
> PHY/switch doesn't provide MII register interface.

Something like that I suppose.  But don't call it "dumb phy",
nor "fake phy", nor anything similar -- there simply is _no_
phy.  If the Linux code wants to pretend there is one, that's
one thing, but there is no need to do any of this trickery in
the device tree.

> Therefore, it should
> use the fixed speed and duplex from device node rather than registers.

Yes.


Segher
