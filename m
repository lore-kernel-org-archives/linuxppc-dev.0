From: david@mind.be
Date: Thu, 19 Dec 2002 16:31:22 +0100
To: BREUVART Jean-Charles <jean-charles.breuvart@airbus.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pb compiling cross gcc, binutils, glibc and so on ...
Message-ID: <20021219163121.T810@mind.be>
References: <36EB27C27D93D4119DE500508BDF85B30B2D710A@TOCOMEXC03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36EB27C27D93D4119DE500508BDF85B30B2D710A@TOCOMEXC03>; from jean-charles.breuvart@airbus.com on Thu, Dec 19, 2002 at 03:52:06PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

> RedHat 8.0 comes with gcc 3.2, binutils 2.13.90.0.2, make 3.79.1, I don't
> know how to get the libc version ...

You can get the libc version by directly executing /lib/libc.so.6

> Here is the trouble :
>
> choose-temp.c:29: stdio.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:30: sys/types.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:32: unistd.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:35: stdlib.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:38: sys/file.h: Aucun fichier ou r?pertoire de ce type

These errors tell you it can't find the header files for your specific target
platform.
You can either copy these from an existing PPC system, or build glibc from
scratch for your system.
A good guide for creating glibc from scratch is to be found at:

http://penguinppc.org/embedded/cross-compiling/

I hope this helps.

Best regards,
David Mazur
--
Mind: Embedded Linux, eCos and JVM development in Europe
http://mind.be                        tel +32-16-309.666

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
