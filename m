Message-ID: <3BBB214A.486AFEE9@digigram.com>
Date: Wed, 03 Oct 2001 16:31:38 +0200
From: Claire Troussier <troussier@digigram.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with Sanpoint and IDE access
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using Montavista 2.4.2_hhl20 with a Sanpoint (8240) board and I am
trying to add a hard disk on the IDE interface. I can access the hard
disk correctly. If the hard disk has previously been formated and
partitionned on another Linux system I can mount all the existing
partitions and access all the files on this hard disk. If I try to write
on it the partition table is totally destroyed and I cannot acces
anymore to the hard disk. It seems that read operations are correctly
performed but not write operations.

In the same way if I try to add a new partition, when I save it the
existing partion table is totally destroyed

Any idea ?

Thanks for your help

Claire


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
