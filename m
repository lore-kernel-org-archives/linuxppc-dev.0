Message-ID: <001501c194df$bdcf6cb0$0100a8c0@industrialDiv.hanasys.co.kr>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC755 and Am79C973 problem.
Date: Fri, 4 Jan 2002 14:22:02 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi?

I'm porting linux on my MPC755 board which use Am79C973 as ethernet controller.
It seams that Am79C973 receives packets correctly.
But the controller never send packet.
Following is the screen shot.

-----------------------------------------------
pcnet32_probe_pci: found device 0x001022.0x002000
    ioaddr=0xbfffe0  resource_flags=0x000101
eth0: PCnet/FAST III 79C973 at 0xbfffe0, 00 90 08 02 dc 50
pcnet32: pcnet32_private lp=c0454000 lp_dma_addr=0x454000 assigned IRQ 18.
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IP-Config: Entered.
IP-Config: eth0 UP (able=3, xid=ce348384)
IP-Config: Complete:
      device=eth0, addr=192.168.0.2, mask=255.255.255.0, gw=192.168.0.1,
     host=192.168.0.2, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.1
------------------------------------------------

After the message the kernel starts to send arp packet to 192.168.0.1 but never succeed.
If I ping from the server(192.168.0.1) to my board(192.168.0.2)
kernel recognizes an arp packet is received and reply to it.
But the server(192.168.0.1) never receives any arp packet.

Does Am79C973 (pcnet32) driver have any problem with powerpc?
I'm using linuxppc-2.4.16.

Thank you in advance.
- Sangmoon Kim -

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
