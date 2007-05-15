Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5CCDDDDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 10:02:43 +1000 (EST)
Date: Mon, 14 May 2007 19:05:45 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Message-ID: <20070515000545.GA4843@lixom.net>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
	<850bd1e3d0b6c5e23a2fe43154591fd9@kernel.crashing.org>
	<200705150156.32737.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705150156.32737.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 01:56:32AM +0200, Arnd Bergmann wrote:
> On Monday 14 May 2007, Segher Boessenkool wrote:
> > > Where should Olof's PCMCIA space go? The ISA or the PHB range?
> > 
> > It uses the legacy IDE I/O addresses, so it needs to
> > go to the 64kB space. 
> 
> How so? All PCMCIA cards should get configured relative to
> socket->io_offset. At least that is where the address used
> in ide_cs.c comes from.

And that'll require the ioaddr_t change on powerpc, but a 32-bit value
is sufficient.


-Olof
