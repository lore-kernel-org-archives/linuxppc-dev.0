Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id E4839DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:20:17 +1000 (EST)
Subject: Panic doesn't reboot
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 14 May 2007 16:20:15 +0200
Message-Id: <1179152415.20638.104.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stumbled across this testing linus tree from last week:

Looking up port of RPC 100003/2 on 192.168.1.15
rpcbind: server 192.168.1.15 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.15
rpcbind: server 192.168.1.15 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.1.15 not responding, timed out
Root-NFS: Server returned error -5 while mounting /opt/rootfs/freescale
VFS: Unable to mount root fs via NFS, trying floppy.
List of all partitions:
1f00         64 mtdblock0 (driver?)
1f01         32 mtdblock1 (driver?)
1f02         32 mtdblock2 (driver?)
1f03        256 mtdblock3 (driver?)
1f04        256 mtdblock4 (driver?)
1f05       1920 mtdblock5 (driver?)
1f06     128384 mtdblock6 (driver?)
No filesystem could mount root, tried: 
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
Rebooting in 180 seconds..

And there it hangs forever. The board is a custom board based on
MPC832x_MDS. Does anybody else see this?

 Jocke
