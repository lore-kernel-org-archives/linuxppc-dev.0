Message-ID: <D96E2AFA0DF3D211B139009027454948037362EA@helios.gnv.tcc.thomson-csf.com>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux Root Filesystem : ROMFS.
Date: Tue, 10 Jun 2003 14:02:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I need some hints about the root filesystem of Linux.

I worked with booting on a NFS ( nfsroot=/ ... ) it works.
I worked with a ramdisk ( initrd = ... ) it works.

Now on a new board I would like to use a romfs. In fact my ram is really
very very little so I would like to keep the filesystem out of the ram. As I
don"t have any ethernet link on the board, nfs can't work on this board.

So I think I gonna use genromfs to build my filesystem.
Then I flash this at @ 0x04000000 that is my flash @.
Then which parameter should I give to Linux ?

BTW : I use u-boot to start Linux.

Thanks.

Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
