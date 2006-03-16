Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 04281679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 07:07:05 +1100 (EST)
To: powerpc440 <powerpc440@googlemail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: glibc, Perl for ppc440GX - compile problems 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 16 Mar 2006 17:09:47 +0100."
	<44198DCB.90508@googlemail.com>
Date: Thu, 16 Mar 2006 21:07:02 +0100
Sender: wd@denx.de
Message-Id: <20060316200702.A79AB353B16@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <44198DCB.90508@googlemail.com> you wrote:
> 
> I'm trying to compile glibc-2.4 on my system but I have the error:

In your subject you mention Perl - what has glibc to do with it?

> ....
> running configure fragment for sysdeps/powerpc/powerpc32/elf
> checking for powerpc32 TLS support... yes
> running configure fragment for sysdeps/unix/sysv/linux/powerpc
> checking whether gcc -g -O2 -mlong-double-128 uses IBM extended format... no
> checking whether gcc -g -O2 supports -mabi=ibmlongdouble... no
> configure: error: this configuration requires -mlong-double-128 IBM 
> extended format support

Are you running the native  compiler  on  the  board,  or  the  cross
compiler? Did you apply all eventually needed patches?

> compiler : GCC 4.0.0 (DENX ELDK 4.0 4.0.0-1), the CPU is PPC440GX, 
> Ocotea based board with own design.

Which architecture did you select? ppc_4xx- ??

> I'm thinking that, the 440GX is not gut supported from GCC 4.0.0 compiler.
> Do anobody already compile glibc and Perl for this platform, or can I 
> find from somewhere .RPM packages?

We build Perl without any problems.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.
