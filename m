Message-ID: <39477CF2.EA4E6F28@esd-electronics.com>
Date: Wed, 14 Jun 2000 14:39:14 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux on MBX860 Board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

I am trying to get a Linux running on a Motorola MBX860 Board. Linux
(Hardhat distribution with Kernel 2.2.13) boots fine and everything is
ok. But only without PCI support. If I enable PCI support, booting stops
with the output below:

...
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v 1.5
Kernel panic: Kernel Mode Software FPU Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation

I am using the default config that came with the kernel. It seems to be
ok !
Can anybody help me ? I still have no more ideas !

Matthias Fuchs

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
