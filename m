Message-ID: <36808F55.71DDCA9A@jlc.net>
Date: Wed, 23 Dec 1998 01:36:05 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: vger CVS questions
References: <Pine.LNX.3.96.981222023432.25778A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> I think another branch would be a bad idea.  Everything in the main tree
> is best for now.

I agree.  Once you get comfortable working with the
kernel you will discover the 8xx modifications are minimal.
Trying to track other kernel updates in a unique 8xx tree
would not be spending time wisely :-).

I created an 8xx directory from the beginning to contain
those things unique to the 8xx.  Right now, it contains
drivers and functions unique to the CPM or other 8xx I/O.

The only things we really need unique to the embedded
processors are support libraries.  They need to be
compiled with software floating point, and minimal.
I was finally successful today building the glibc SRPM
for the 8xx processors.  I will drop it on the server and
build a new embedded root file system image with them.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
