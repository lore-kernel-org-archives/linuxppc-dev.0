From: ghannon@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256B61.00681797.00@pine.cspi.com>
Date: Fri, 15 Feb 2002 14:03:25 -0500
Subject: MVME5100 booting from SCSI disk - fixed sort of
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the feedback.

I was able to flash the board with a working kernel and have it mount the
root filesystem on the HD.  I have a YDL distribution, and the partitioning
tools I have are parted and pdisk, but of which didn't like type 41.
(Perhaps I was trying to create the partition wrong?)

I will eventually try to get fdisk going and see if that can do it on
another
disk.   For my current development I'm going to keep it like this.

Thanks again!
G. Hannon


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
