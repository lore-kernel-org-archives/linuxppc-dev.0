Content-Type: text/plain;
  charset="us-ascii"
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: NFS root woes: No init found
Date: Wed, 4 Dec 2002 16:35:31 -0500
MIME-Version: 1.0
Message-Id: <200212041635.31861.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
	I am attempting to boot up a custom PPC board and having problems with the
NFS Root. the board has a single 74xx PPC and Galileo memory controller. What
happens is everything looks good until I attempt to read init from the NFS
root. Then I get the message No init found. I have tried the obvious things
such as changing init for a staticly linked executable, to no avail. I have
enabled NFS debug and it looks like I have mounted the remote fs just fine.
In fact, I can remove /dev/console and watch console_init() throw a warning.
Has anyne seen problems with the Galileo's mii ports or any other boards
booting an NFS root filesystem? I am attaching the end of my log below.
Thanks
Brian


NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
gt64260_eth_open : Assigned IRQ 32 to gt64260_eth0
eth0:  link state:
  GT: 100: Link:FD:nFC
 mii:100: Link:FD:nFC ANnc:Manual
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.9.200.220, my address is 192.9.200.246
IP-Config: Complete:
      device=eth0, addr=192.9.200.246, mask=255.255.255.0, gw=255.255.255.255,
     host=seblade2, domain=, nis-domain=(none),
     bootserver=192.9.200.220, rootserver=192.9.200.220, rootpath=/home/ppc
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: Mounting /home/ppc on server 192.9.200.220 as root
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Looking up port of RPC 100003/2 on 192.9.200.220
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 192.9.200.220
Root-NFS: mountd port is 32771
NFS:      nfs_mount(c009c8dc:/home/ppc)
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 188k init
Kernel panic: No init found.  Try passing init= option to kernel.
 <0>Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
