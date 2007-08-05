Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13245DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 10:15:29 +1000 (EST)
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit DMA
	mapping"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <46B4B7C6.1040107@s5r6.in-berlin.de>
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca>  <46B4B7C6.1040107@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sun, 05 Aug 2007 10:15:26 +1000
Message-Id: <1186272926.938.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > If setting 32-bit DMA mask fails on ppc64, that sounds like a problem
> > with the DMA implementation on that architecture. There are enough cards
> > out there that only support 32-bit DMA that this really needs to work..
> 
> Yes, could the PPC folks please have a look at it?  Thanks.

Smells like we may have a bug there. No worries though, all current PPC
machines have an iommu that will not give out addresses above 32 bits
anyway, but I'll double check what's up.

Do you see something in dmesg when that happens ?

Ben.
