Message-ID: <39D89C8F.4F328DAF@home.com>
Date: Mon, 02 Oct 2000 09:32:47 -0500
From: Tim Montgomery <tjmontgo@home.com>
MIME-Version: 1.0
To: Linux PPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: flying blind with BATs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello,

I am trying to get the ppc kernel loaded on a 750-based embedded board,
and I've got an ultra-basic bootloader (the board is not PReP or
CHRP-compliant), but I believe I am having trouble with the BAT
mappings.

I have the BATs configure (by the bootloader) such that 0xc0000000
(virtual) is mapped to 0x00000000 (phys SDRAM base), but after
the image is decompressed (to the virtual addr), I get garbage when
I do a dump at 0xc0000000 (i.e. the kernel isn't there.)

I am executing the bootloader itself out of a region well above
(4MB) the kernel space.

Before I spend too much time reinventing the wheel (and beating my
head against the wall), I was curious if there was a 7xx-based
bootloader out there that I could modify to fit my needs.

Any other pointers/tips regarding machine state required on a 750
prior to jumping to the kernel would also be appreciated.

Regards,
Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
