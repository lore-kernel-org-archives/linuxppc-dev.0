Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF73D9B8D@NAPA>
From: Hua Ji <hji@netscreen.com>
To: Wang Yong <wung_y@263.net>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: gdb load address and KERNELLOAD
Date: Tue, 3 Apr 2001 20:04:46 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Usually, if

1. you want have soem fun
2. Your physical memory size is bigger than 1G,

You will try to change the PAGE_OFFSET, which is the 0xC00000000.

Anyway, please find the link script as well as the PAGE_OFFSET settings in
your corresponding arch directory and you will get the answer, even though
this is usually discouraged.

Regards,

Mike

-----Original Message-----
From: Wang Yong [mailto:wung_y@263.net]
Sent: Tuesday, April 03, 2001 5:57 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: gdb load address and KERNELLOAD



Hi, all:
  I am debugging embedded Linux( linux-2.2.13 for MPC8XX) using bdm/wiggler.
I do this
on windowsNT with cygwin and insight downloaded from www.ocdemon.com. The
question is: how
can I download the vmlinux to a different address from KERNELLOAD which is
set to 0xc0000000.
I want to do this because the SDRAM is mapped to 0x00000000 and the MMU is
of course not enabled
when I download the kernel image via gdb. any comment on this subject is
welcome.

  thank you.

W.Y.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
