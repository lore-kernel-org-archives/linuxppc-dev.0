Message-ID: <409A015D.80205@fh-landshut.de>
Date: Thu, 06 May 2004 11:11:57 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Using MotLoad as flash bootloader???
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

The MVME5500 directly supports booting a Linux kernel from the net and
from disk. A ROM/RAM/flash boot option seems to be missing.

Does anybody know, how to use the Motload to boot a kernel from flash
(maybe with the ELF-loader, or by putting a kernel in a correct place).

I already tried loading the kernel (PPLUS image) into memory and
executing it directly (with offsets 0 and 100 from its load address) and
putting the BUGBOOT image into the start of both flash banks (reserved
as kernel space anyway by the supplied MTD partition mapping).

It would be really nice to know if somebody has solved this problem, or
if somebody could give some useful hints!

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
