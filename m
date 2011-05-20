Return-Path: <richardcochran@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47EACB7195
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 23:23:41 +1000 (EST)
Received: by fxm1 with SMTP id 1so3143565fxm.15
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 06:23:37 -0700 (PDT)
Date: Fri, 20 May 2011 15:23:29 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20110520132328.GA5785@riccoc20.at.omicron.at>
References: <1305777978.7481.37.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305777978.7481.37.camel@pasglop>
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

On Thu, May 19, 2011 at 02:06:18PM +1000, Benjamin Herrenschmidt wrote:
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

When I try to build 'next' (now at 208b3a4c), it does not compile due
to a change from the following commit.

> Benjamin Herrenschmidt (1):
>       powerpc/smp: Make start_secondary_resume available to all CPU variants

I would appreciate your help in getting this fixed...

Thanks,
Richard

PS the error looks like this:

  AS      arch/powerpc/kernel/misc_32.o
arch/powerpc/kernel/misc_32.S: Assembler messages:
arch/powerpc/kernel/misc_32.S:703: Error: Unrecognized opcode: `std'
make[2]: *** [arch/powerpc/kernel/misc_32.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2

> ${CROSS_COMPILE}gcc -v
Using built-in specs.
Target: powerpc-none-linux-gnuspe
Configured with: ../gcc-4.3.2/configure --target=powerpc-none-linux-gnuspe --host=i686-pc-linux-gnu --prefix=/opt/freescale/usr/local/gcc-4.3.74-eglibc-2.8.74-dp-2/powerpc-none-linux-gnuspe --with-sysroot=/opt/freescale/usr/local/gcc-4.3.74-eglibc-2.8.74-dp-2/powerpc-none-linux-gnuspe/powerpc-none-linux-gnuspe/libc --disable-libssp --disable-libmudflap --disable-libstdcxx-pch --enable-libgomp --enable-shared --enable-threads --enable-languages=c,c++ --with-gmp=/usr/src/redhat/BUILD/csl-tc-4.3.74/host-libs/usr --with-mpfr=/usr/src/redhat/BUILD/csl-tc-4.3.74/host-libs/usr --with-cpu=8548 --with-gnu-as --with-gnu-ld --enable-symvers=gnu --enable-__cxa_atexit --enable-cxx-flags=-mcpu=8548 --disable-multilib --with-long-double-128 --disable-nls --enable-e500_double
Thread model: posix
gcc version 4.3.2 (GCC) 
