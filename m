Message-ID: <20040530191435.43618.qmail@web11001.mail.yahoo.com>
Date: Sun, 30 May 2004 12:14:35 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: Flush Journal in EXT3 filesystem
To: linuxppc-embedded@lists.linuxppc.org
Cc: tliang@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am working on a custom board running Linux 2.4.19.
The filesystem is EXT3 which is configured to journal
meta data only. During the booting up of the board,
sometimes I saw the mount command takes a long time
(about 5 seconds or so).

I think this delay is due to the previous unexpected
shutdown, e.g. due to power-cycle of the system, etc,
some filesystem data blocks are logged in the journal
log and have not been flushed onto the disk, and
during the mount command, the are being written back
to the disk.

My questions is whether we can control when to flush
the data from the log to the disk. For example, can
sync command be modified to do that? Are there any
filesystem IOCTL I can use to flush the journal?

Thanks.

Regards,

Terry L.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
