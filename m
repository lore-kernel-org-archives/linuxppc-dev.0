Message-ID: <000501c28f63$18d742d0$1200a8c0@hardware03>
From: "cheng" <chete@21cn.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: what's wrong about the  psim 
Date: Tue, 19 Nov 2002 08:31:53 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi! All
  After  I had downloaded the ppcboot sourcecode and made it. Then I run it in the psim but it print the errors.

Administrator@HARDWARE-03 /cygdrive/d/cygwin/usr/soft/ppcboot-2.0.0
$ powerpc-elf-run -m 603e ppcboot
cpu 1, cia 0xfff00000: program interrupt - illegal instruction
ppcboot: Caught signal -1 at address 0xfff00000

Administrator@HARDWARE-03 /cygdrive/d/cygwin/usr/soft/ppcboot-2.0.0
$ powerpc-elf-run -m 603e -e chirp  ppcboot
/memory@0: failed to allocate 98304 bytes at 0xfff00000
my board is base on MPC8245 ,so it is a 603e core.
what¡¯s wrong ?pls help me .
Best wishes,
chete

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
