Message-ID: <3EDCD9EF.6080703@ecubics.com>
Date: Tue, 03 Jun 2003 11:25:03 -0600
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: ELDK, linuxppc_devel, IDE drives on HPT372
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Anybody out here got the ide drives working on a hpt372 controller ?
(ELDK, linuxppc_devel from CVS, 8245 CPU)

On my board, the controller get correctly detected, but fails to find
any drive:

----------------------------------------------------------------------

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT372: IDE controller on PCI bus 00 dev 50
HPT372: chipset revision 5
HPT372: not 100% native mode: will probe irqs later
HPT366/368/370/370A/372
HPT370: using 33MHz PCI clock
     ide0: BM-DMA at 0xfebffe00-0xfebffe07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xfebffe08-0xfebffe0f, BIOS settings: hdc:pio, hdd:pio
probing for hda: present=0, media=32, probetype=ATA

----------------------------------------------------------------------

went to all four hda, hdb, hdc, hdd and boots then from NFS.

Any ideas ?

cheer,
emanuel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
