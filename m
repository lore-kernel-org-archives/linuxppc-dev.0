Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97A85DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 10:08:29 +1100 (EST)
Message-ID: <47DEF9E7.5030808@freescale.com>
Date: Mon, 17 Mar 2008 18:08:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
References: <20080317175208.GA17844@localhost.localdomain>	
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>	
	<47DEE6CF.7040801@freescale.com>
	<1205792537.7589.64.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1205792537.7589.64.camel@gentoo-jocke.transmode.se>
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

> eth0 is also up, was it commit 4942bd80e83d13bf394df4a8109bee39d861820f
> that fixed that bug?

Yep.  Unfortunately, I don't really know enough about the ucc_geth driver to
know what could be wrong.  I just noticed your message and remembered that old bug.

-- 
Timur Tabi
Linux kernel developer at Freescale
