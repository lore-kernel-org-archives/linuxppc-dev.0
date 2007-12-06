Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9084EDDEDB
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 00:34:57 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB6DYoWA013299
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 08:34:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB6DYoAA134074
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 08:34:50 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB6DYoNP024727
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 08:34:50 -0500
Date: Thu, 6 Dec 2007 07:32:01 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/25] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071206073201.5bd84d64@zod.rchland.ibm.com>
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
References: <1196927999.714593.205329520306.qpush@grosgo>
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

On Thu, 06 Dec 2007 18:59:59 +1100
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

You should update your tree at some point.  Your patches apply with
fuzz because Paul's tree has changes apparently yours doesn't.

josh
