Date: Thu, 03 Apr 2003 01:11:18 -0700
Message-ID: <3E8BECA6.6060709@asu.edu>
From: "Donald White" <dbwhite@asu.edu>
To: "linux-embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Subject: Question about porting VxWorks driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting a Vxworks driver for an encryption chip from Vxworks to Linux on a
cutom MPC860 board.  The Linux is HHL 2.0.  The driver communicates with the chip
through chip registers and shared memory buffers.  The VxWorks driver set the system
memory cache policy to writethrough.  I am using ioremap for the chip registers and
consistent_alloc for the shared buffers.  This all works fine.  Now for my questions.

Is this the right approach for me to take?  Does Linux support designating memory
regions for writethrough caching?  If it does, should I use it rather than doing
what I am doing?

Thanks,

Don


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
