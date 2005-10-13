Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 12C67684E3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 00:52:50 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 13 Oct 2005 16:52:32 +0200
References: <4dd15d180510130720m45089eafk10cd9936457ced8b@mail.gmail.com>
	<4dd15d180510130725o3c23326i6f9703015401a381@mail.gmail.com>
In-Reply-To: <4dd15d180510130725o3c23326i6f9703015401a381@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200510131652.33612.g.jaeger@sysgo.com>
Cc: David Ho <davidkwho@gmail.com>
Subject: Re: NPTL support on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 13 October 2005 16:25, David Ho wrote:
> glibc used on ELDK 3.0 is still using linuxthreads.
> 
> David
> 
> bash-2.05# ./libc.so.6
> GNU C Library stable release version 2.3.1, by Roland McGrath et al.
> Copyright (C) 2003 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.
> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> Compiled by GNU CC version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1).
> Compiled on a Linux 2.4.24-pre2 system on 2004-02-17.
> Available extensions:
> GNU libio by Per Bothner
> crypt add-on version 2.1 by Michael Glad and others
> linuxthreads-0.10 by Xavier Leroy
> BIND-8.2.3-T5B
> libthread_db work sponsored by Alpha Processor Inc
> NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
> software FPU emulation by Richard Henderson, Jakub Jelinek and others
> Report bugs using the `glibcbug' script to <bugs@gnu.org>.
> 
> 
> On 10/13/05, David Ho <davidkwho@gmail.com> wrote:
> >
> > Hi all,
> >
> > Just out of curiosity, is NPTL support already available on PPC?
> >
> > I believe there are 2 parts to it. Kernel support which is probably
> > already there in 2.6. And the other is glibc, is there a generally
> > available toolchain (i.e. ELDK) that already support NPTL?
> >
> > Thanks, David

Yes it's available! you might want to checkout the work done around
the crosstool project (http://www.kegel.com/crosstool) or check my
sig ;)

-/bin/sh-3.00# /lib/tls/libc.so.6
GNU C Library stable release version 2.3.4, by Roland McGrath et al.
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 3.4.4.
Compiled on a Linux 2.6.12.6-elinos-214 system on 2005-09-28.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
        software FPU emulation by Richard Henderson, Jakub Jelinek and others
Thread-local storage support included.

Ciao,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
