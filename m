Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E16D6DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 19:39:24 +1000 (EST)
Subject: Re: [PATCH 6/7] MPIC MSI allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <f5dd623fbb338d38bc05567ee178b886@kernel.crashing.org>
References: <1176968125.531108.326168797246.qpush@cradle>
	<20070419073555.D2C3EDDEFD@ozlabs.org>
	<20070423035025.GA29839@lixom.net>
	<1177378169.14873.46.camel@localhost.localdomain>
	<f5dd623fbb338d38bc05567ee178b886@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 19:39:11 +1000
Message-Id: <1177407551.14873.105.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 11:26 +0200, Segher Boessenkool wrote:
> >> It's time to rename BROKEN_U3. It used to be the config option to 
> >> enable
> >> a few workarounds, but now it's used to select whenever there's a U3 
> >> in
> >> the system. Care to do it in the scope of this patch set?
> >
> > Not really.... first gen G5s don't use that :-) It's wether the MPIC is
> > part of U3/U4 -and- is used as a primary HT PIC.
> 
> Not really...  It is whether the HT-to-MPIC interface
> on the U3/U4 has the "feature" that ack-required
> interrupts coming in over HT need to be acked by hand.
> 
> First-gen G5's need that just as well, they just don't
> have such interrupts on the default system configuration,
> as far as I remember.

They didn't have an HT APIC or if they had one, they didn't enable it
(they probably did in the tunnel). They didn't use the U3 MPIC as an HT
IRQ master, thus it's irrelevant. Anyway, there is no point in this
discussion :-)

Ben.
