Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 1E9DBDDF90
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:22:19 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <47DEE6CF.7040801@freescale.com>
References: <20080317175208.GA17844@localhost.localdomain>
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>
	<47DEE6CF.7040801@freescale.com>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 23:22:16 +0100
Message-Id: <1205792537.7589.64.camel@gentoo-jocke.transmode.se>
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


On Mon, 2008-03-17 at 16:46 -0500, Timur Tabi wrote:
> Joakim Tjernlund wrote:
> 
> > Trying to add fixed-link support for ucc_geth as this is broken too. I
> > noticed that ifconfig eth1 up follwed by ifconfig eth1 down hangs
> > my board once I got the ucc_geth driver to recognize fixed-link.
> > Does it work for you?
> 
> A long time ago there was a bug where "ifconfig eth1 down" would cause a kernel
> panic if eth0 was also up.  The root cause was a bug in rheap.c.  However, this
> code was fixed a year ago.  Could it be a similar bug?

eth0 is also up, was it commit 4942bd80e83d13bf394df4a8109bee39d861820f
that fixed that bug? 2.6.23 works fine for me.

      Jocke
