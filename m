Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7117FDDF94
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 02:01:26 +1100 (EST)
Date: Fri, 17 Oct 2008 17:01:12 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Message-ID: <20081017150112.GA14523@Chamillionaire.breakpoint.cc>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
	<20081015144359.GA30649@Chamillionaire.breakpoint.cc>
	<1224252131.7879.117.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1224252131.7879.117.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Nate Case | 2008-10-17 09:02:11 [-0500]:

>On Wed, 2008-10-15 at 16:43 +0200, Sebastian Andrzej Siewior wrote:
>> With this patch it compiles and boots fine.
>> The option -mabi=no-spe is not required.
>
>Please don't accept this patch yet.  My past testing showed that
>"-mabi=no-spe" was required for my toolchain.  I'll go back and double
>check though.
Okay. Here my compiler details:

| powerpc-linux-gnuspe-gcc -v 
| Using built-in specs.
| Target: powerpc-linux-gnuspe
| Configured with: ../src/configure -v --with-pkgversion='Debian 4.3.1-9'
| --with-bugurl=file:///usr/share/doc/gcc-4.3/README.Bugs
| --enable-languages=c,c++,obj-c++ --prefix=/usr --enable-shared
| --with-system-zlib --libexecdir=/usr/lib --without-included-gettext
| --enable-threads=posix --enable-nls
| --with-gxx-include-dir=/usr/powerpc-linux-gnuspe/include/c++/4.3.1
| --program-suffix=-4.3 --enable-clocale=gnu --enable-libstdcxx-debug
| --disable-multilib --disable-multilib --with-cpu=8540
| --enable-e500_double --with-long-double-128 --enable-checking=release
| --program-prefix=powerpc-linux-gnuspe-
| --includedir=/usr/powerpc-linux-gnuspe/include --build=i486-linux-gnu
| --host=i486-linux-gnu --target=powerpc-linux-gnuspe
| Thread model: posix
| gcc version 4.3.1 (Debian 4.3.1-9) 
 
ths told me that we need all three options in this order because of how
they interact with gcc's internal flags.

>- Nate Case <ncase@xes-inc.com>

Sebastian
