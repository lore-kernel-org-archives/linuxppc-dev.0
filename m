Return-Path: <paul.gortmaker@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65B21B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 08:33:33 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <70ca52c20908110709m41b1535ep4c8ed900163f3b18@mail.gmail.com>
References: <70ca52c20908110709m41b1535ep4c8ed900163f3b18@mail.gmail.com>
Date: Tue, 11 Aug 2009 17:42:26 -0400
Message-ID: <7d1d9c250908111442kec430c1me20cc02d3e4fd60c@mail.gmail.com>
Subject: Re: cross compiling wind river linux for ppc architecture
From: Paul Gortmaker <paul.gortmaker@gmail.com>
To: Sridhar Mahadevan <msridhar87@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2009 at 10:09 AM, Sridhar Mahadevan<msridhar87@gmail.com> wrote:
> Hi,
> Am trying to compile my WRL 2.6.21 kernel for PPC architecture.
> The processor am using is AMCC powerpc 440EP .

This isn't really the best choice of forum for trying to get help like this.
Most of the people here are focused on working with the latest development
kernels, and won't have the time to go back and look at year-old kernels
based on the now removed PPC architecture.

Plus they won't necessarily have any knowledge of what the WRL specific
changes may or may not contain.  If you have the opportunity to do so,
the best choice for you would be to go through the normal WR support
channels with full details of your problem.

At a glance, it looks like you are trying to build with ARCH=powerpc, and
yet I don't think (from memory) that the 4xx boards had migrated from
ARCH=ppc until sometime around the 2.6.24-ish timeframe.

Paul.

> I just built the file system by running the configure command with
> --enable-rootfs=glibc-small and --enable-cpu-ppc-440 and i got a cross
> compiler.
> I took the linux kernel image and updated the PATH variable to the path of
> my cross compiler.I did a make with ARCH=powerpc and CROSS_COMPILER=/my
> cross compiler,except gcc/.
>
> When I try to do this I get the following error.
> arch/powerpc/mm/44x_mmu.c: In function 'mmu_mapin_ram':
> arch/powerpc/mm/44x_mmu.c:106: error: 'PPC_PIN_SIZE' undeclared (first use
> in this function)
> arch/powerpc/mm/44x_mmu.c:106: error: (Each undeclared identifier is
> reported only once
> arch/powerpc/mm/44x_mmu.c:106: error: for each function it appears in.)
> arch/powerpc/mm/44x_mmu.c:106: error: 'PPC44x_PIN_SHIFT' undeclared (first
> use in this function)
> arch/powerpc/mm/44x_mmu.c:109: error: 'PPC44x_LOW_SLOT' undeclared (first
> use in this function)
> make[1]: *** [arch/powerpc/mm/44x_mmu.o] Error 1
> make: *** [arch/powerpc/mm] Error 2
> It ll be very helpful for me if I could get a solution for this.
>
> Regards
> Sridhar M
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
