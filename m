Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F89DDDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:01:08 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Add NEW EMAC driver support to 440EPx Sequoia
	board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071015122616.08250b54@weaponx.rchland.ibm.com>
References: <20071012130305.GA14682@ru.mvista.com>
	<20071015122616.08250b54@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 06:59:46 +1000
Message-Id: <1192481986.11795.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-15 at 12:26 -0500, Josh Boyer wrote:
> On Fri, 12 Oct 2007 17:03:05 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
> > This patch enables NEW EMAC support for PowerPC 440EPx Sequoia board
> > and adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> > These PHY chips are used on PowerPC440EPx boards.
> > The PHY code is based on the previous work by Stefan Roese <sr@denx.de>
> 
> Could you send the phy part to Jeff Garzik and the netdev list by
> itself?  That way it will get picked up and we'll update the Kconfig
> with a later patch.

Oh and please CC me :-)

Ben.
