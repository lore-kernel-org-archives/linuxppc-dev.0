Message-ID: <D53137D1F3DDD211A3750800060DA3130170238B@viee122a.erd.siemens.at>
From: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting Linux on MPC860ADS with BOOTP and TFTP?
Date: Tue, 28 Mar 2000 16:05:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Does anyone know a bootloader for the MPC860ADS board, which supports
booting Linux using BOOTP and TFTP to get the kernel and using NFS for the
root file system?

Currently I´m trying to get the board running using 8xxROM from Raphael
Bossek, but unfortunately my ADS board has only 2MB flash (not enough for a
ROM_DISK option) and I have no PCMCIA flash card.

BTW: Wherefrom can I get a root filesystem if I buy a ATA flash card? How
big should this flash card be? Is a Sandisk compact flash with a PCMCIA
adapter ok?

Is there any alternative for my limited flash memory? (Put the kernel in the
flash, but mount the root filesystem with NFS?).

Best regards,
Thomas.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
