Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: David Jander <david.jander@protonic.nl>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling glibc-2.3.2 (debian) on mpc8xx ;-)
Date: Tue, 9 Mar 2004 09:53:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403090953.54598.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I proudly announce that we finally have the first two prototypes of our boards
based on the MPC852T running. Until now it looks like one of those lucky
"one-time-right" designs, since it went flawless until now. We have 64 MByte
SDRAM on-board, an ethernet Phy (FEC), 4 Mbyte Flash, etc...
Since I'm quite crazy, and love running "big-stuff" on "small-things" I
decided to install Debian-unstable (sid) on an nfs-mounted root.
So far, so good. I compiled a kernel with FPU-emulation just in case, and went
through the installation of the base system using glibc-2.3.1 from ELDK
binaries plugged on top of the version from debian, to avoid further
incompatibilities.
Now, after apt-getting a hell of a lot of fancy software (all running quite
fine until now - except floating-point-libc stuff), the time has come to
recompile GlibC..... on the target!

Question: What do I have to patch exactly before compiling? I want to leave
floating-point stuff in there for now to stay compatible with
debian-binaries. AFAIK there is (was?) an issue with
sysdeps/powerpc/powerpc32/memset.S and sysdeps/powerpc/powerpc32/dl-machine.c
containing code that assumed a cache-line of different size than that of the
MPC8xx. Is this still the case in glibc-2.3.2? Hasn't this been patched in
the official sources?
What else do I have to look out for? What other patches to apply? Where to get
them from?

Greetings,

--
David Jander
Protonic Holland.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
