Message-ID: <36A7CD79.D769782E@jlc.net>
Date: Thu, 21 Jan 1999 19:59:38 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Kernel 2.2p7 for embedded
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




I just finished the merge of the 8xx embedded processor changes
to the 2.2-pre7 kernel.  They can be found on linuxppc.cs.nmt.edu
in the embedded directory.

I created a patch file as well against the kernel.org original.  This
is not completely useful by itself since there are several new files
not represented in the patch.  This is mainly for porting references.

In addition to the merge, it also includes Cort's new interrupt handler
functions.  Cort, take a look at this because there were some minor
changes I had to make :-).

The CPM Ethernet driver (all but 860T) includes modfications sent
to me by Pierre Vandwalle.  This is better but there is still some bug
there that is getting my attention.

I have run this kernel on my MBX, RPX-Lite and BSE ip-Engine boards.
The only requirement is at least 6 MBytes of DRAM.  I have not yet
tested initrd.

Upcoming events.   The kernel still enables write-through cache.  I will
upload the new ld.so that is required for copy-back cache (it assumes a
cache line size that is not correct on the 8xx).  I will also upload all of
libraries that are built from the glibc RPM.  These have software floating
point and enable many more programs to work correctly.  I also have some
programs built for the software floating point world that I will upload as well.

I also see that I am _still_ behind the latest kernel :-).


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
