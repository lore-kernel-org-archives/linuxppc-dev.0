Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s14.bay0.hotmail.com (bay0-omc1-s14.bay0.hotmail.com
	[65.54.246.86]) by ozlabs.org (Postfix) with ESMTP id 980E7DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 02:10:25 +1000 (EST)
Message-ID: <BAY138-F28B91E8B47A7F29AB017C5B2D10@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: grant.likely@secretlab.ca
Subject: NFS failed in linux-2.6-virtex tree for xilinx ML403
Date: Sun, 26 Aug 2007 16:09:06 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Grant,
I am bringing up your linux-2.6-virtex tree. However the following problem 
happened:

eth0: XTemac: speed set to 1000Mb/s
eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
IP-Config: Complete:
      device=eth0, addr=192.168.0.4, mask=255.255.255.0, gw=192.168.0.3,
     host=192.168.0.4, domain=, nis-domain=(none),
     bootserver=192.168.0.3, rootserver=192.168.0.3, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.3
rpcbind: server 192.168.0.3 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 0.0.0.16 not responding, timed out
Root-NFS: Server returned error -5 while mounting 
/home/mingliu/ml403_rootfs
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option; here are the available 
partitions:
fe00     509544 xsa (driver?)
  fe01      98248 xsa1
  fe02     402192 xsa2
1f00       8192 mtdblock0 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(2,0)
Rebooting in 180 seconds..

My CMD_LINE is "root=/dev/nfs 
nfsaddrs=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw 
nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyS0,9600 mem=32M"

First of all, I can exclude the problem of my host PC, because the old 
2.6.10 version could run with nfs and root directory mounted successfully. 
So what's wrong with the NFS support in the new kernel? It's quite strange 
that in the information above, why "mount: server 0.0.0.16 not responding", 
rather than the server of 192.168.0.3 which should be there? Do you have 
any hint? Thanks a lot in advance.

Best Regards
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
