Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2CF3EDDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 13:55:55 +1100 (EST)
Date: Mon, 2 Mar 2009 18:55:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc allnoconfig
Message-Id: <20090302185514.2cc73512.akpm@linux-foundation.org>
In-Reply-To: <20090303135203.b36312a0.sfr@canb.auug.org.au>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Mar 2009 13:52:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Mon, 2 Mar 2009 18:40:49 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > It's a cross-compiler: http://userweb.kernel.org/~akpm/cross-compilers/
> 
> What does
> "/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-gcc -v" say?

Using built-in specs.
Target: powerpc64-unknown-linux-gnu
Configured with: /home/axboe/crosstool-0.43/build/powerpc64-unknown-linux-gnu/gcc-4.1.0-glibc-2.3.6/gcc-4.1.0/configure --target=powerpc64-unknown-linux-gnu --host=x86_64-host_unknown-linux-gnu --prefix=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu --disable-multilib --with-sysroot=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/powerpc64-unknown-linux-gnu/sys-root --with-local-prefix=/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/powerpc64-unknown-linux-gnu/sys-root --disable-nls --enable-threads=posix --enable-symvers=gnu --enable-__cxa_atexit --enable-languages=c --enable-shared --enable-c99 --enable-long-long
Thread model: posix
gcc version 4.1.0

> I suspect you have a 64 bit only compiler and allnoconfig produces a 32
> bit kernel.  Is this a new error?

2.6.28 does the same thing.  I don't recall having tested allnoconfig
for ages if at all, so I don't know if it's a regression.
