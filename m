From: philippe.villet@acterna.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <C1256BF2.00591EE2.00@magnus.eni.wago.de>
Date: Wed, 10 Jul 2002 18:04:34 +0200
Subject: ppc405_phy.c : Slow NFS access with DP83846A ethernet controller
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are booting linux MVL2.1 on our custom board but NFS access are very slow.
Our board is very close to the Walnut one except the ethernet controller (PHY)
We are using a  DP83846A instead of DP83843 on the walnut.

The DP83846A seems to be supported in drivers/net/ppc405_phy.c, we just need to
modify the PHY id (from 0x20005c23 to 0x20005c20).

Does anyone have troubles with the DP83846A ?
Is there a difference between 0x20005c23 id devices  and 0x20005c20 ?
Any idea ?

Thanks in advance.

Phil.

Here is our boot log  console :

Linux version 2.4.17_mvl21-walnut (pvillet@ensun16.se.wavetek.com) (gcc version
2.95.3 20010315 (release/
MontaVista)) #12 mer jui 10 16:26:03 CEST 2002
...
...
eth0: Phy @ 0x1, type DP83846A (0x20005c20)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Reset ethernet interfaces
eth0: PPC405 EMAC: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: PPC405 EMAC: MAC 00:04:ac:e3:14:94.
eth0: PPC405 Enet open completed
IP-Config: Complete:
      device=eth0, addr=172.16.27.117, mask=255.255.252.0, gw=255.255.255.255,
     host=172.16.27.117, domain=, nis-domain=(none),
     bootserver=172.16.26.45, rootserver=172.16.26.45, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.26.45
Looking up port of RPC 100005/1 on 172.16.26.45
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 68k init
INIT: version 2.78 booting
nfs: server 172.16.26.45 not responding, still trying
nfs: server 172.16.26.45 OK
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
Setting kernel variables.
Mounting local filesystems...
not mounted anything
Hostname: serdmq7111.
Cleaning: /tmp /var/lock /var/run.
nfs: server 172.16.26.45 not responding, still trying
nfs: server 172.16.26.45 OK
Checking password and group files... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
nfs: server 172.16.26.45 not responding, still trying
nfs: server 172.16.26.45 not responding, still trying
nfs: server 172.16.26.45 OK
MontaVista Software's Hard Hat Linux 2.0

serdmq7111 login:


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
