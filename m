Message-ID: <392317F8.F32062C6@embeddededge.com>
Date: Wed, 17 May 2000 18:06:48 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more on e2fsck
References: <3922CB9E.873738B6@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> when I run mke2fs /dev/sda2 it creates a file system just fine.

Oh, I'll just make a wild guess here.....SCSI disks on 8xx.....:-).
How many pieces of untested hardware (and software) are in this path?

Have you written a simple program to make sure you can read/write
sectors on the disk without errors?  I, like the others, have e2fsck
working on PCMCIA "disk" devices.  The sources compile just fine.  I
suppose someone could compile and test something for you to verify it
works.  I don't have anything handy at the moment, but I will add it
to my list.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
