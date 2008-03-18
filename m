Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 3F9AFDE1B9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:19:50 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <47DFD29B.5050502@freescale.com>
References: <20080317175208.GA17844@localhost.localdomain>
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>
	<47DEE6CF.7040801@freescale.com>
	<1205792537.7589.64.camel@gentoo-jocke.transmode.se>
	<47DEF9E7.5030808@freescale.com>
	<1205831779.7589.80.camel@gentoo-jocke.transmode.se>
	<47DFD29B.5050502@freescale.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 16:19:48 +0100
Message-Id: <1205853588.7589.110.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-18 at 09:32 -0500, Timur Tabi wrote:
> Joakim Tjernlund wrote:
> 
> > Found it, the eth1 i/f on this board isn't working and does not generate
> > any clocks which makes ugeth_graceful_stop_tx() hang forever.
> 
> Well, that doesn't make it very graceful, does it? :-)

Nope, :)
> 
> Can you fix this yourself, or do you want me to file an internal bug report?  If
> so, can you email me a detailed description of the problem?

I fixed it by adding a counter which aborts after 100 loops. If you
could move along the 2 patches I sent today, "Add Fixed PHY support for
ucc_geth" and "ucc_geth: Add 8 bytes to max TX frame for VLANs" into
2.6.25 that would be great :)

 Jocke
