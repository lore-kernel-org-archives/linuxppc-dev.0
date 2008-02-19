Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 05D28DE128
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 07:19:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so2246181anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 12:19:08 -0800 (PST)
Date: Tue, 19 Feb 2008 14:17:34 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: 2.6.24 for mpc8458amc
Message-ID: <20080219141734.73f1e755@zod.rchland.ibm.com>
In-Reply-To: <47BB177E.1070602@freescale.com>
References: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
	<47BAE6B3.7090000@freescale.com>
	<dda529d0802190642n56ef7fbcx988ce8825bd315da@mail.gmail.com>
	<47BAEE3F.2070209@freescale.com>
	<dda529d0802190838h7c72b590gc6b26ed868bac8e5@mail.gmail.com>
	<47BB177E.1070602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: maxime louvel <m.louvel@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 11:53:02 -0600
Scott Wood <scottwood@freescale.com> wrote:

> maxime louvel wrote:
> > Hi again,
> > 
> > this time I have tried to compile the kernel, with an embedded compiler 
> > on the board.
> > here is the result...
> > 
> > ....
> >   BOOTAS  arch/powerpc/boot/ps3-hvcall.o
> >   BOOTCC  arch/powerpc/boot/ps3.o
> >   BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
> >   BOOTCC  arch/powerpc/boot/cuboot-8xx.o
> >   BOOTCC  arch/powerpc/boot/cuboot-pq2.o
> >   BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
> >   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> > Assembler messages:
> > Error: Internal assembler error for instruction icbt
> > Internal error, aborting at ../../gas/config/tc-ppc.c line 1300 in 
> > ppc_setup_opcodes
> > Please report this bug.
> > make[2]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
> > make[1]: *** [uImage] Error 2
> > make: *** [sub-make] Error 2
> 
> That's a bug in older toolchains, which is aggravated by a misguided 
> policy that we build all wrapper platforms, always.  Either use a newer 
> toolchain, or remove treeboot-walnut from arch/powerpc/boot/Makefile.

It would be good to know what versions of binutils and gcc are being
used though.

josh
