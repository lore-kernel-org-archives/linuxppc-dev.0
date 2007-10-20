Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CD3FDDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 11:30:10 +1000 (EST)
Subject: Re: [BUG] powerpc does not save msi state [was Re: [PATCH 5/7]
	pci: Export the pci_restore_msi_state() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20071020004610.GR29903@austin.ibm.com>
References: <20071019232926.GL29903@austin.ibm.com>
	<1192840577.5369.9.camel@dell> <20071020000421.GO29903@austin.ibm.com>
	<20071019.172706.57467960.davem@davemloft.net>
	<20071020004610.GR29903@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 11:29:40 +1000
Message-Id: <1192843780.17235.17.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Ellerman <ellerman@au1.ibm.com>, netdev@vger.kernel.org,
	mcarlson@broadcom.com, linuxppc-dev@ozlabs.org,
	mchan@broadcom.com, linux-pci@atrey.karlin.mff.cuni.cz,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm cc'ing the powerpc mailing list to point this out: 
> it looks like only cell/axon_msi.c and mpic_u3msi.c 
> bother do do anything.  I guess that there aren't any old 
> macintosh laptops that have msi on them? Because without
> this, suspend and resume breaks.

The only macs that can do any form of MSIs are the G5s using
mpic_u3msi.c

> Paul,
> On the off chance your reading this, I'll send a pseries
> patch on Monday, with luck (and some other patches too).
> I'm not touching any of the other plaforms, you and benh 
> would know those better.

Or rather Michael as he wrote the ppc MSI support. I'll check with him

Ben.
