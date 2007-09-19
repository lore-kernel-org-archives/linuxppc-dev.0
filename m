Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFCF2DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 19:29:08 +1000 (EST)
Date: Wed, 19 Sep 2007 10:28:48 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: 2.6.23-rc6-mm1 -- powerpc link failure
Message-ID: <20070919092848.GG973@shadowen.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918011841.2381bd93.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am seeing this strange link error from a PowerMac G5 (powerpc):

  [...]
    KSYM    .tmp_kallsyms2.S
    AS      .tmp_kallsyms2.o
    LD      vmlinux.o
  ld: dynreloc miscount for fs/built-in.o, section .opd
  ld: can not edit opd Bad value
  make: *** [vmlinux.o] Error 1

Compiler version below.

root@elm3b19:~# gcc -v
Using built-in specs.
Target: powerpc-linux-gnu
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr
--enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --enable-nls
--program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-awt=gtk-default
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --with-cpu=default32
--disable-werror --enable-checking=release powerpc-linux-gnu
Thread model: posix
gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)

-apw
