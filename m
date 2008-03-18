Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5AA1DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 01:33:06 +1100 (EST)
Message-ID: <47DFD29B.5050502@freescale.com>
Date: Tue, 18 Mar 2008 09:32:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
References: <20080317175208.GA17844@localhost.localdomain>	
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>	
	<47DEE6CF.7040801@freescale.com>	
	<1205792537.7589.64.camel@gentoo-jocke.transmode.se>	
	<47DEF9E7.5030808@freescale.com>
	<1205831779.7589.80.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1205831779.7589.80.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:

> Found it, the eth1 i/f on this board isn't working and does not generate
> any clocks which makes ugeth_graceful_stop_tx() hang forever.

Well, that doesn't make it very graceful, does it? :-)

Can you fix this yourself, or do you want me to file an internal bug report?  If
so, can you email me a detailed description of the problem?

-- 
Timur Tabi
Linux kernel developer at Freescale
