Message-Id: <200403241240.i2OCeakY022508@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: linux booting problem: init start up very slowly and print kernel infor character by character
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 24 Mar 2004 20:39:44 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
   In the process of porting linux to a new board, I got a very strange thing:

  Booting infomation:
		.......
		mice: PS/2 mouse device common for all mice
		VFS: Mounted root (ext2 filesystem) readonly.
		Freeing unused kernel memory: 64k init
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~before this, everything is OK.
		INIT: version 2.84 booting
  			              Welcome....
        From "INIT", system seems to start very slowly. "INIT" and other kernel infomation were printed out character  by character with some kind of delay between them.It took even five minutes to mount a proc file system.
        What could be the problem?
		Is this becuase of disk configuation problem since init is the first program got called from disk?

Jack Liu
Jack_liu@usish.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
