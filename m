Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 13 May 2004 13:07:25 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc-82xx_objcopy hangs
Message-ID: <20040513110725.GU4043@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am in the process of porting our MPC8245 system to the MVista 3.1
(from 2.1). Just like with the kernel, this requires major code cleanup
in the kernel (sources I 'inherited' when starting :( ).

After cleaning the kernel sources and patching the 3.1 kernel, I want to
cleanup ppcboot and move to u-boot. I intend to do this in a 2-step
process.

1. compile a clean patch from ppcboot-2.0.0 to ppcboot-2.0.0-custom
2. port the patch to u-boot

I have the following problem:

1. ppcboot-2.0.0 compiles cleanly on the 3.1 env. for a board (a README
config).
2. when compiling the ppcboot-2.0.0-custom sources (with support for our
system), the compilation succeeds, but
ppc_82xx-objcopy --gap-fill=0xff -O srec ppcboot ppcboot.srec
gets stuck.

Idem for a system where I only brought in a couple of changes from the
old sources. Any ideas as to what code might cause this problem?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
