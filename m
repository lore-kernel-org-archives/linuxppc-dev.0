Message-ID: <619D608DD3F0D311882C009027732E1A35320B@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: 2.4.6 kernel on MCP750 board
Date: Wed, 18 Jul 2001 09:54:41 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I am trying to put the latest kernel on Motorola MCP750 card. 2.2 kernel
used to work fine, but 2.4.6 have some PCI problems.
It can not allocate resources to network interface and, as a result, I can
not boot.
Startup dump attached.

Any help is appreciated,
Thanks,
Rudolf


PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/4801] 000600 00
Fixup res 1 (200) of dev 00:00.0: 3c000000 -> fc000000
Found 00:58 [1106/0586] 000601 00
Found 00:59 [1106/0571] 000101 00
Found 00:5a [1106/3038] 000c03 00
Found 00:5b [1106/3040] 000000 00
Found 00:70 [1011/0009] 000200 00
Fixup res 1 (200) of dev 00:0e.0: 3bffff00 -> fbffff00
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Found 00:a0 [1011/0026] 000604 01
Fixups for bus 00
Memory resource not set for host bridge 0
Scanning behind PCI bridge 00:14.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
PCI: Unable to handle 64-bit address space for
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:14.0, config 010100, pass 1
Bus scan for 00 returning with max=01
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
PCI:00:00.0: Resource 1: fc000000-fc03ffff (f=200)
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI:00:0b.1: Resource 0: 0000fff0-0000fff7 (f=101)
PCI: Cannot allocate resource region 0 of device 00:0b.1
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 1: 0000ffec-0000ffef (f=10d)
PCI: Cannot allocate resource region 1 of device 00:0b.1
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 2: 0000ffe0-0000ffe7 (f=101)
PCI: Cannot allocate resource region 2 of device 00:0b.1
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 3: 0000ffdc-0000ffdf (f=10d)
PCI: Cannot allocate resource region 3 of device 00:0b.1
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0b.1: Resource 4: 0000ffc0-0000ffcf (f=101)
PCI: Cannot allocate resource region 4 of device 00:0b.1
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0b.2: Resource 4: 0000ffa0-0000ffbf (f=101)
PCI: Cannot allocate resource region 4 of device 00:0b.2
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0e.0: Resource 0: 0fffff00-0fffff7f (f=101)
PCI: Cannot allocate resource region 0 of device 00:0e.0
PCI: parent is c01cf030: 00000000-ffffffff (f=100)
PCI:00:0e.0: Resource 1: fbffff00-fbffff7f (f=200)
PCI: Cannot allocate resource region 1 of device 00:0e.0
PCI: Failed to allocate resource 0(1000-1007) for 00:0b.1
PCI: Failed to allocate resource 1(1000-1003) for 00:0b.1
PCI: Failed to allocate resource 2(1000-1007) for 00:0b.1
PCI: Failed to allocate resource 3(1000-1003) for 00:0b.1
PCI: Failed to allocate resource 4(1000-100f) for 00:0b.1
PCI: Failed to allocate resource 4(1000-101f) for 00:0b.2
PCI: Failed to allocate resource 0(1000-107f) for 00:0e.0
PCI: Failed to allocate resource 1(c0000000-bfffffff) for 00:0e.0
Activating ISA DMA hang workarounds.
PCI: Via IRQ fixup for 00:0b.2, from 16 to 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard reset failed, no ACK
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
block: queued sectors max/low 20002kB/6667kB, 64 slots per queue
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
PCI: Unable to reserve I/O region #1:80@1000 for device 00:0e.0



/************************/
Rudolf Ladyzhenskii
Senior DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 190 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
