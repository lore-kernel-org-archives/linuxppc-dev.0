Message-ID: <42AB6BE23C29D511831E0002B3202488199989@messenger.radlan.co.il>
From: Ofer Rashuk <OferR@Radlan.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel panic while Booting 8240
Date: Sun, 30 Sep 2001 12:19:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
I'm using 8240 on a costume board with Monta Vista LSP.
while booting after system has been mounted i am receiving an Kernel Panic.
I'm not sure what parameters i need to pass to init.
dose any body have an idea?


eth0: OEM i82557/i82558 10/100 Ethernet, 00:A0:F7:33:34:35, IRQ 18.
  Board assembly 000101-001, Physical connectors present: MII
  Primary interface chip i82555 PHY #1.
  Forcing 10Mbs half-duplex operation.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xd6a8ca49).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 176.210.1.1, my address is 176.210.100.174
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 176.210.100.112
Looking up port of RPC 100005/2 on 176.210.100.112
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 180k init 4k openfirmware
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..


Ofer Rashuk-Rosenthal.
Software team leader.
RADLAN Computer Communication ltd.
Atidim Technological Park, Blgd. 4
Tel-Aviv 61131, Israel

Tel:+972-3-7657924
Fax:+972-3-6487368
mailto:oferr@radlan.com
Web : Http://www.radlan.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
