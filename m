Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6730BDDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 06:45:49 +1000 (EST)
Date: Sun, 23 Sep 2007 14:44:33 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
Message-ID: <20070923144433.6cafd233@vader.jdub.homelinux.org>
In-Reply-To: <fa686aa40709230832m1d4a083ao2e43b57cc39e088@mail.gmail.com>
References: <Pine.LNX.4.44.0709231519510.25165-100000@slslc02.psi.ch>
	<fa686aa40709230832m1d4a083ao2e43b57cc39e088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, Miroslaw Dach <miroslaw.dach@psi.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 23 Sep 2007 09:32:25 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 9/23/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > Hi Grant,
> >
> > Thank you very much for your advices which were very valuable for me.
> >
> > Recently I have followed your advice to move from kernel 2.6.21 to the
> > higher one in order to have the possibility to boot the kernel from
> > u-boot. I have copied across from you git tree the latest version of linux
> > kernel 2.6.23 rc-2.
> >
> > It compiles successfully with some warnings like below:
> >   MODPOST vmlinux.o
> > WARNING: vmlinux.o(.text+0x223c): Section mismatch: reference to .init.text:early_init (between 'start_here' and 'initial_mmu')
> > WARNING: vmlinux.o(.text+0x2254): Section mismatch: reference to .init.text:machine_init (between 'start_here' and 'initial_mmu')
> > WARNING: vmlinux.o(.text+0x2258): Section mismatch: reference to .init.text:MMU_init (between 'start_here' and 'initial_mmu')
> > WARNING: vmlinux.o(.text+0x22b2): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
> > WARNING: vmlinux.o(.text+0x22b6): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
> >    LD      vmlinux
> 
> Yes, I see this warning too.  I haven't had a chance to debug it.

This warning should be fixed in arch/powerpc.  You could probably look
at the fix there and port it to arch/ppc.

josh
