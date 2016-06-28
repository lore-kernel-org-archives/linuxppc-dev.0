Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf2fH4NmQzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:51:03 +1000 (AEST)
In-Reply-To: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Pat Wall <pjwall@mac.com>, matthew@a-eon.com, aperez@alexperez.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: Proposed: Patch to fix boot on PA6T
Message-Id: <3rf2fH2Yy7z9sdg@ozlabs.org>
Date: Tue, 28 Jun 2016 20:51:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Darren,

On Sun, 2016-26-06 at 17:42:11 UTC, Darren Stevens wrote:
> Hello All,
> 
>     commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
>     powerpc/mm: vmalloc abstraction in preparation for radix
> 
>     This commit introduced variables for some linux kernel addresses that had before
>     been constants, unfortunately this stopped PaSemi PA6T systems(*) from  booting as
>     they call ioremap to map SoC registers before the mmu is initialised. The attached
>     patch adds a hard-coded init of pci_io_base to the pas_init_early() function which
>     which allows the kernel to boot normally.
> 
>     The value will be harmlessly set again once pci starts up.
> 
>     (*) At the moment this has only been tested on an AmigaOneX1000, but I expect PaSemi
>     reference systems to have been affected in the same way.
> 
> Kind regards
> Darren

I can't merge this because you didn't sign it off.

See section 11 of:

  https://www.kernel.org/doc/Documentation/SubmittingPatches

cheers
