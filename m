Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC833DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:21:45 +1100 (EST)
Message-ID: <47DFDE00.8030504@freescale.com>
Date: Tue, 18 Mar 2008 10:21:36 -0500
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
	<47DFD29B.5050502@freescale.com>
	<1205853588.7589.110.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1205853588.7589.110.camel@gentoo-jocke.transmode.se>
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

> I fixed it by adding a counter which aborts after 100 loops. If you
> could move along the 2 patches I sent today, "Add Fixed PHY support for
> ucc_geth" and "ucc_geth: Add 8 bytes to max TX frame for VLANs" into
> 2.6.25 that would be great :)

I have no control over that, sorry.  You'll have to ask Jeff G or maybe Kumar to
pick up those patches.

-- 
Timur Tabi
Linux kernel developer at Freescale
