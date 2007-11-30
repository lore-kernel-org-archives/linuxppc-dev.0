Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB822DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:19:32 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAUKJSOL009665
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:19:28 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAUKJSV0494000
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:19:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAUKJSAm005505
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:19:28 -0500
Date: Fri, 30 Nov 2007 14:17:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071130141756.3aa3d38b@zod.rchland.ibm.com>
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
References: <1196403038.569525.367459803520.qpush@grosgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007 17:10:38 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Here's a set of patches that bring PCI, PCI-X and PCI-Express
> support to 4xx on arch/powerpc. It also changes/fixed various
> bits and pieces, such as a bit of rework of arch/powerpc/boot
> 4xx code, adding a couple of new platforms along the way. 
> 
> There are some issues with the SCSI stack vs. non-coherent
> DMA that I'm working on fixing separately, and there's a
> problem I noticed with the e1000 driver vs. 64 bits resources
> on 32 bits architectures for which I also have a patch that
> I posted separately. Appart from that, I got it working fine
> with a USB2 card in an ebony and 2 USB storage devices.
> 
> Some of these patches are _NOT_ yet candidate for merging
> (mostly the board support ones), but you can review them and
> Josh can put them in an experimental tree.

I've added these to the 2.6.25-candidates branch in my tree.  Fixed up
the few conflicts manually.  I'll expect refreshes before merging
anyway, but I'd like to get these out there for people to play with.

josh
