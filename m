Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B526AB71A7
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 08:59:50 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20110520132328.GA5785@riccoc20.at.omicron.at>
References: <1305777978.7481.37.camel@pasglop>
	<20110520132328.GA5785@riccoc20.at.omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 May 2011 08:21:21 +1000
Message-ID: <1305930081.7481.190.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 15:23 +0200, Richard Cochran wrote:
> On Thu, May 19, 2011 at 02:06:18PM +1000, Benjamin Herrenschmidt wrote:
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
> 
> When I try to build 'next' (now at 208b3a4c), it does not compile due
> to a change from the following commit.
> 
> > Benjamin Herrenschmidt (1):
> >       powerpc/smp: Make start_secondary_resume available to all CPU variants
> 
> I would appreciate your help in getting this fixed...

It's me being a moron. I'll send a fix to Linus.

Cheers,
Ben.

> Thanks,
> Richard
> 
> PS the error looks like this:
> 
>   AS      arch/powerpc/kernel/misc_32.o
> arch/powerpc/kernel/misc_32.S: Assembler messages:
> arch/powerpc/kernel/misc_32.S:703: Error: Unrecognized opcode: `std'
> make[2]: *** [arch/powerpc/kernel/misc_32.o] Error 1
> make[1]: *** [arch/powerpc/kernel] Error 2
> 
> > ${CROSS_COMPILE}gcc -v
> Using built-in specs.
> Target: powerpc-none-linux-gnuspe
> Configured with: ../gcc-4.3.2/configure --target=powerpc-none-linux-gnuspe --host=i686-pc-linux-gnu --prefix=/opt/freescale/usr/local/gcc-4.3.74-eglibc-2.8.74-dp-2/powerpc-none-linux-gnuspe --with-sysroot=/opt/freescale/usr/local/gcc-4.3.74-eglibc-2.8.74-dp-2/powerpc-none-linux-gnuspe/powerpc-none-linux-gnuspe/libc --disable-libssp --disable-libmudflap --disable-libstdcxx-pch --enable-libgomp --enable-shared --enable-threads --enable-languages=c,c++ --with-gmp=/usr/src/redhat/BUILD/csl-tc-4.3.74/host-libs/usr --with-mpfr=/usr/src/redhat/BUILD/csl-tc-4.3.74/host-libs/usr --with-cpu=8548 --with-gnu-as --with-gnu-ld --enable-symvers=gnu --enable-__cxa_atexit --enable-cxx-flags=-mcpu=8548 --disable-multilib --with-long-double-128 --disable-nls --enable-e500_double
> Thread model: posix
> gcc version 4.3.2 (GCC) 
