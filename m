Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 04B1867BEF
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 00:36:53 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so1972462nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 07:36:51 -0700 (PDT)
Message-ID: <787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
Date: Sat, 12 Aug 2006 10:36:51 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <17629.48408.564322.747132@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/12/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > I just ran paxtest on a Mac G4 Cube. Ouch. The results are shameful.
>
> What gcc version, what binutils version, what kernel version?

My gcc claims to be:

Using built-in specs.
Target: powerpc-linux-gnu
Configured with: ../src/configure -v
--enable-languages=c,c++,java,fortran,objc,obj-c++,ada,treelang
--prefix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --enable-nls
--program-suffix=-4.1 --enable-__cxa_atexit --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-awt=gtk --enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.1-1.4.2.0/jre
--enable-mpfr --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --with-cpu=default32
--enable-checking=release powerpc-linux-gnu
Thread model: posix
gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)

I suppose binutils can be determined by ld:

GNU ld version 2.16.91 20060413 Debian GNU/Linux

The kernel version was reported:

Linux cube 2.6.17-rc5 #1 PREEMPT Sat May 27 20:35:12 EDT 2006 ppc GNU/Linux
