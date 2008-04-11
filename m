Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 5CD73DE137
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 20:47:08 +1000 (EST)
Subject: Re: [PATCH 1/5] phylib: don't create a phydev for ID-less PHYs.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804111006.04708.sr@denx.de>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<1207897589.9544.13.camel@gentoo-jocke.transmode.se>
	<200804111006.04708.sr@denx.de>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 12:47:06 +0200
Message-Id: <1207910826.9544.26.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-net@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-11 at 10:06 +0200, Stefan Roese wrote:
> On Friday 11 April 2008, Joakim Tjernlund wrote:
> > On Thu, 2008-04-10 at 13:51 -0400, Paul Gortmaker wrote:
> > > In addition to marking 0x0 as an invalid PHY ID, I've also
> > > changed the existing somewhat useless printk to actually
> > > list the bus IDs where it found a PHY so we get a basic
> > > bus summary.
> >
> > PHY ID 0x0 isn't an invalid id, I got a Broadcom PHY that has
> > PHY ID=0. Maybe I am misunderstanding something?
> 
> IIRC, address 0 is the PHY broadcast address, but can be used without problem 
> with some PHY's. I remember some designs were we had the PHY at address 0.

Ouh, if that is so, I guess we need a CONFIG option or a new mdio bus
property to select if PHY ID 0 is valid id or not.

 Jocke
