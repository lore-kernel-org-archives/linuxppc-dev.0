Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Stable File System for embedded product
Date: Mon, 19 Jan 2004 11:53:49 +0530
MIME-Version: 1.0
Message-Id: <200401191153.50014.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to find which file system is the best for
/etc partition on an embedded linux platform.

I am using the following file systems for linux & rootfs:-
Linux: CramFS (linux 2.4.20 denx) (read-only)
RootFS: CramFS  (read-only)

At the moment, I am using ext2 partition for /etc (read-write)
But, 1 out of  4 power-cycles of the board corrupts the
/etc partition.

Any information related to the above topic is
grately appreciated.

Regards,
S. Hebbar.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
