Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44BE2DDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:16:36 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board 
In-Reply-To: Your message of "Tue, 13 Feb 2007 06:55:08 +1100."
	<1171310108.20192.7.camel@localhost.localdomain>
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
	<1171310108.20192.7.camel@localhost.localdomain>
Date: Mon, 12 Feb 2007 14:16:21 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HGhb3-0001fb-9M@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> 
> Note that there are still things that we might want to change. For
> example, I think we really should look into adding a macro mecanism
> and/or an include mecanism to dtc so that we can do things like #include
> <ibm440gp.dtc> to get the base processor/SoC definition and then
> "overlay" some properties on top of it (like emac phy mode etc...)

What do people prefer here?  Straight CPP pre-run?
Direct support built into dtc to do file-inclusion, macros?

Thoughts, opinions, suggestions, pre-NACKs, Cabernet Franc bribes?

jdl
