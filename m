Date: Fri, 7 Sep 2001 12:31:40 +0200
From: Marius Groeger <mag@sysgo.de>
Message-Id: <200109071031.f87AVeW09279@dagobert.svc.sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pthread support in ppc405 gdb
In-Reply-To: <3B96BA46.6040604@ixiacom.com>
References: <3B96BA46.6040604@ixiacom.com>
Reply-To: mag@sysgo.de
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In linux.ppc.embedded, Bryan Rittmeyer wrote:

> We have a mission-critical need for a ppc405 source level debugger
> (gdb) which can handle complex, threaded C++ applications. However,
> the HHL 2.0 release notes say the following:
>
> * gdb 5.0
>    gdb 5.0 included with HHL 2.0 does not support
>    debugging multi-threaded (pthread) applications.

The current gdb snapshots have fairly decent support for pthreads. I'd be
careful though with "complex, threaded C++ applications". That has always
beed a problem with gdb (at least on other platforms where threads were
supported). This is - at least partially - due to the inherent, er,
weirdness of C++.

Elinos does support pthread debugging btw.

Regards
Marius.

----------------------------------------------------------------------
Marius Groeger        SYSGO Real-Time Solutions GmbH    www.sysgo.de
Software Engineering  Embedded and Real-Time Software   www.osek.de
mgroeger @ sysgo de   Germany                           www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
