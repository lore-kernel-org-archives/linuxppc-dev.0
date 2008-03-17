Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC8F9DDFE6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 08:47:02 +1100 (EST)
Message-ID: <47DEE6CF.7040801@freescale.com>
Date: Mon, 17 Mar 2008 16:46:55 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
References: <20080317175208.GA17844@localhost.localdomain>
	<1205782935.7589.55.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1205782935.7589.55.camel@gentoo-jocke.transmode.se>
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

> Trying to add fixed-link support for ucc_geth as this is broken too. I
> noticed that ifconfig eth1 up follwed by ifconfig eth1 down hangs
> my board once I got the ucc_geth driver to recognize fixed-link.
> Does it work for you?

A long time ago there was a bug where "ifconfig eth1 down" would cause a kernel
panic if eth0 was also up.  The root cause was a bug in rheap.c.  However, this
code was fixed a year ago.  Could it be a similar bug?

-- 
Timur Tabi
Linux kernel developer at Freescale
