Message-ID: <20010125092351.13410.qmail@dag.newtech.fi>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Advice on good disk bootloader
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jan 2001 11:23:51 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have ported Linux to a PPC VME board here and
am using PMON as the startup monitor.
So far I have booted through TFTP with goo success
but now I would need to start the system from disk.

The monitor can load a raw disksegment, starting
from a certain address with a certain length as an ELF-file
and run it.

Is there good advice on which diskformat to use (fdisk ?)
and on a good first stage bootloader that then would
understand the ext2fs ?

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
