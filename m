Date: 14 Aug 2003 19:08:19 -0000
Message-ID: <20030814190819.31581.qmail@webmail35.rediffmail.com>
MIME-Version: 1.0
From: "anu  k" <anuk_mv@rediffmail.com>
Reply-To: "anu  k" <anuk_mv@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with EEPro100 and Sandpoint board
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am using an EEpro100 driver with a Sandpoint X3 board and am running into problems with BooTP.

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
ttyS01 at 0xfe0002f8 (irq = 3) is a 16550A
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c: Debug level is 10.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Found Intel i82557 PCI Speedo, MMIO at 0xbffff000, IRQ 21.
eth0: PCI device 8086:1030, 00:00:82:58:50:02, IRQ 21.
  Board assembly 742252-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x8b51f404).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
TCP: Hash tables configured (established 2048 bind 4096)
Sending BOOTP requests .<7>eth0: Link status change.
.<7>eth0: Media control tick, status 2050.
.<7>eth0: Media control tick, status 2050.
.<7>eth0: Media control tick, status a050.
.<7>eth0: Media control tick, status a050.
.<7>eth0: Media control tick, status a050.
 timed out!
IP-Config: Retrying forever (NFS root)...
Sending BOOTP requests .<7>eth0: Link status change.
.<7>eth0: Media control tick, status 2050.
.
The BooTP server seems to be responding to the requests, but the packets are getting lost at the client end. Not quite sure if its a driver problem or has something to do with the new Sandpoint board revision.
Regds,
Anuk
___________________________________________________
Meet your old school or college friends from
1 Million + database...
Click here to reunite www.batchmates.com/redif

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
