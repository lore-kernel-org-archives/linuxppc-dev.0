From: "Wang Yong" <wung_y@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb load address and KERNELLOAD
Date: Wed, 4 Apr 2001 08:57:27 +0800
Message-ID: <GEEHLABKDEENGODIMGHAGEFGCAAA.wung_y@263.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all:
  I am debugging embedded Linux( linux-2.2.13 for MPC8XX) using bdm/wiggler. I do this
on windowsNT with cygwin and insight downloaded from www.ocdemon.com. The question is: how
can I download the vmlinux to a different address from KERNELLOAD which is set to 0xc0000000.
I want to do this because the SDRAM is mapped to 0x00000000 and the MMU is of course not enabled
when I download the kernel image via gdb. any comment on this subject is welcome.

  thank you.

W.Y.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
