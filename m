Message-ID: <20020123114107.84624.qmail@web14006.mail.yahoo.com>
Date: Wed, 23 Jan 2002 12:41:07 +0100 (CET)
From: =?iso-8859-1?q?Andr=E9s=20Chamorro?= <achamoro@yahoo.es>
Subject: Compact Flash on PCMCIA in MBX860 without IDE
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
i trying to run a Compact Flash on MBX860,
i have a 2.4.2_hhl20 Montavista Kernel and  Linux
PCMCIA Card Services 3.1.22 running on the board.
Kernel has MTD support.
Kernel has msdos,vfat support.
When I put the Compact Flash into the socket the next
message appear:

fatfs: bogus cluster size
VFS: Can't find a valid MSDOS filesystem on dev fd:00.

I put the compact flash into a windows laptop and all
is ok.

The complete message show in var/log/syslog -->
kernel: Linux PCMCIA Card Services 3.1.22
kernel:   kernel build: 2.4.2_hhl20 #7 mar ene 22
05:27:29 CET 2002
kernel:   options:  none
kernel: m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus
Damm
kernel: m8xx_pcmcia: MBX860 using SLOT_A with IRQ 13.
cardmgr[108]: starting, version is 3.1.22
cardmgr[108]: watching 1 sockets
cardmgr[108]: initializing socket 0
cardmgr[108]: socket 0: TOSHIBA THNCF032MAA
cardmgr[108]: executing: 'modprobe sram_mtd'
cardmgr[108]:   Common memory region at 0x0: Generic
or SRAM
cardmgr[108]: executing: 'modprobe memory_cs'
kernel: sram_mtd: common at 0x0, 2 kb, 250 ns
kernel: memory_cs: mem0: common 2 kb
cardmgr[108]: executing: './memory start mem0'
cardmgr[108]: + mem0
kernel: fatfs: bogus cluster size
kernel: VFS: Can't find a valid MSDOS filesystem on
dev fd:00
cardmgr[108]: + mount: wrong fs type, bad option, bad
superblock on /dev/mem0c0b,
cardmgr[108]: +        or too many mounted file
systems
cardmgr[108]: start cmd exited with status 1

thanks a lot.




Yahoo! Messenger
Comunicación instantánea gratis con tu gente.
http://messenger.yahoo.es

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
