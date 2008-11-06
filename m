Return-Path: <jason.m.hanna.at.coincident@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id B6636DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 16:40:18 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so307603fga.39
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Nov 2008 21:40:16 -0800 (PST)
Message-ID: <8f9e78f00811052140u2263ebfdj7455363a3c92a046@mail.gmail.com>
Date: Thu, 6 Nov 2008 00:40:16 -0500
From: "Jason Hanna" <jason.m.hanna.at.coincident@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: KGDB Question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

Sorry for the newb questions, but I'm trying to setup KGDB for my
embedded development environment and I'm slightly confused.

Compiling a 2.6.27.3 kernel for a Kilauea (PowerPC 405EX) development
board. U-boot 1.3.2 on target and ELDK 4.2 cross-tools on Debian
(Lenny) host. Everything works fine w/regard to cross-compiling,
booting, etc.

Now trying to configure KGDB so I can do some kernel/driver coding and
debugging. Have enabled KGDB and DEBUG_INFO config options and
re-compiled my target kernel. Here's where I start to get confused:

1.) When configuring the kernel should I be seeing I/O driver options
for serial or ethernet ports? I don't. Looking at some older examples
online it seems there were options for selecting a serial port or
ethernet during kernel config. Reading the KGDB DocBook (Ch 2) leads
me to believe I should see some I/O driver options.

2.) Tried setting "kgdboc=ttyS0,115200" and "kgdbwait" (in that order)
as boot args in U-Boot. Boot begins and pauses after kernel and device
tree are loaded. Attempting to run "target remote /dev/ttyS0" on my
host and getting: Ignoring packet error, continuing...(3 times) and
Malformed response to offset query, timeout. Pretty sure I've got
everything connected correctly, but back to item #1 not sure I'm
missing an I/O driver or have some other issue?

3.) What is the status of KGDB in the 2.6.27 tree? It seems to have
been added to the kernel in previous versions, but I can't tell if
it's complete and working properly for my architecture. Should I be
attempting to use the patch from the KGDB sourceforge project?

Thanks,
-jmh
