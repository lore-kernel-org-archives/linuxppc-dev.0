Return-Path: <jhautbois@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 4A990B7108
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 03:01:05 +1100 (EST)
Received: by wyb35 with SMTP id 35so7573722wyb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Nov 2010 08:01:03 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 8 Nov 2010 17:00:58 +0100
Message-ID: <AANLkTimLEQBdV3GaneQo76Tn2mC6L2K2r_Y9DxO8a5QW@mail.gmail.com>
Subject: Better performance when CONFIG_DEBUG_KERNEL is on
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi everybody,

I am using a mpc5200 chip with a linux 2.6.33.7-rt29.
I am using the ELDK toolchain :

ppc_6xx-gcc -v

Target: powerpc-linux
Configured with:
/opt/eldk/build/ppc-2008-04-01/work/usr/src/denx/BUILD/crosstool-0.43/build/gcc-4.2.2-glibc-20070515T2025-eldk/powerpc-linux/gcc-4.2.2/configure
--target=powerpc-linux --host=i686-host_pc-linux-gnu
--prefix=/var/tmp/eldk.UZpAG7/usr/crosstool/gcc-4.2.2-glibc-20070515T2025-eldk/powerpc-linux
--disable-hosted-libstdcxx
--with-headers=/var/tmp/eldk.UZpAG7/usr/crosstool/gcc-4.2.2-glibc-20070515T2025-eldk/powerpc-linux/powerpc-linux/include
--with-local-prefix=/var/tmp/eldk.UZpAG7/usr/crosstool/gcc-4.2.2-glibc-20070515T2025-eldk/powerpc-linux/powerpc-linux
--disable-nls --enable-threads=posix --enable-symvers=gnu
--enable-__cxa_atexit --enable-languages=c,c++,java --enable-shared
--enable-c99 --enable-long-long --without-x
Thread model: posix
gcc version 4.2.2

When I have the CONFIG_DEBUG_KERNEL flag, the latencies I am mesuring
are better than when the flag is off.
And the jitter is lower...

I must tell I am confused. I have no explanation about that, except
maybe optimisations which would be different when the -g flag is
added...

If any of you has an idea, I am looking forward for your response :).

Thanks in advance,
Best Regards.
JM
