Message-ID: <20040115003734.87843.qmail@web11005.mail.yahoo.com>
Date: Wed, 14 Jan 2004 16:37:34 -0800 (PST)
From: Xupei Liang <tliang@yahoo.com>
Subject: Unused sectors in the ATA drive
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Our custom board (supports PPC 440 and Linux 2.4.19
with XFS filesystem) has an ATA/IDE hard drive on it.
The hard drive is partitioned into two MS-DOS
partitions by the "parted" utility.  From the content
of the MBR, I found that the first partition starts at
sector 0x20. Now, the questions are:
1) Can I use sectors 1-0x20 to store private data?
2) Will current version or future versions of Linux
use these sectors?

Thank you.

Regards,

Terry L.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
