Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C552DE227
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 07:03:36 +1100 (EST)
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <20070127183028.GA18523@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<17850.33971.762011.194195@cargo.ozlabs.ibm.com>
	<20070127183028.GA18523@colo.lackof.org>
Content-Type: text/plain
Date: Sun, 28 Jan 2007 07:02:55 +1100
Message-Id: <1169928175.24996.203.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> My impression was any CPU that uses an IO-SAPIC (or -xAPIC) is
> using bus transactions to communicate interrupts even if they
> aren't using MSI. BIOS typically hides all the setup.
> 
> Alpha also uses bus transactions for IO interrupts. But I've read
> through my ancient alpha reference manual and don't understand
> exactly if the vector is part of the "DMA" transaction or is read
> by the CPU off the I/O Bridge ("hose").
> 
> > Or do you mean there is some piece of hardware in the northbridge (or
> > elsewhere) that accepts the MSI message writes and asserts an
> > interrupt line to the CPU?  That is basically what we have on PPC.
> 
> *grin* PPC in this case looks more like "legacy x86" than x86 does today.
> /me hides

Well, actually, Cell also has interrupts as packets on the bus :-)

(Though the way it's done on cell, you typically still need an external
interrupt controller for anything that's not on-chip unfortunately).

Ben.
