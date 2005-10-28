Return-Path: <xiay@nari-relays.com>
Received: from NARI-RELAYS.COM (unknown [221.226.124.170])
	by ozlabs.org (Postfix) with ESMTP id D4F5A6855F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 12:42:08 +1000 (EST)
Date: Fri, 28 Oct 2005 10:54:11 +0800
Message-Id: <200510281054.AA34079032@NARI-RELAYS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "=?ISO-8859-1?Q?=CF=C4=D3=EA?= " <xiay@nari-relays.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: NFS can not mount (linuxppc2.2.4 mpc5200 lxt971)
Reply-To: xiay@nari-relays.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have ported linuxppc2.2.4 to my board based on ICECUBE.
One board can not mount NFS(eth0 = lxt971), Message as follow:

eth0: config: auto-negotiation on, 100HDX, 10HDX.
IP-Config: Complete:
      device=eth0, addr=198.87.102.211, mask=255.255.255.0, gw=198.87.102.140,
     host=oops, domain=, nis-domain=(none),
     bootserver=198.87.102.140, rootserver=198.98.102.140, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 198.98.102.140
eth0: status: link up, Unknown speed/duplex, auto-negotiation complete, remote f
ault.
portmap: server 198.98.102.140 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 198.98.102.140
portmap: server 198.98.102.140 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 198.98.102.140 not responding, timed out
Root-NFS: Server returned error -5 while mounting /opt/eldk/ppc_82xx
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00

But i can ping the board from my PC:

Pinging 198.87.102.211 with 32 bytes of data:

Reply from 198.87.102.211: bytes=32 time<10ms TTL=64
Reply from 198.87.102.211: bytes=32 time<10ms TTL=64
Reply from 198.87.102.211: bytes=32 time<10ms TTL=64
Reply from 198.87.102.211: bytes=32 time<10ms TTL=64


The other boards using the same program can mount NFS on the same server.

What part of this board might be wrong? 

Thanks!
