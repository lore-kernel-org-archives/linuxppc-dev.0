Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5096167C39
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 06:44:41 +1100 (EST)
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
	<1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
	<C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 06:44:25 +1100
Message-Id: <1166125466.31351.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-12-14 at 15:46 +0100, Segher Boessenkool wrote:
> >>> if get_property("msi_available")
> >>> 	mpic_msi_reserve_dt_irqs()
> >>
> >> available-msi is a better name now that I think of it, or better  
> >> even:
> >> "msi-ranges"
> >
> > "msi-ranges" is ambiguous, are the ranges available or reserved?
> >
> > How about "msi-available-ranges" :D
> 
> The property describes vectors that are not (yet) in use by
> the hardware; so let's do "available-vectors"?

If we are going to be pedantic, it should be msi-available-sources :-)

Ben.
