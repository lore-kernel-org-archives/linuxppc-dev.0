Message-ID: <36A37938.FC241BB6@jlc.net>
Date: Mon, 18 Jan 1999 13:11:04 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Gary Thomas <gthomas@cygnus.co.uk>
CC: Michael Meissner <meissner@cygnus.com>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
References: <XFMail.990118130140.gthomas@cygnus.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Thomas wrote:

> Here's what I got to work (patches):

Yeah.  You just moved the free space out of the way of the image
you loaded.  That is the right thing to do, now we just need to make
this happen

Let's take Cort's suggestion and break the loader.  Make it work
correctly for the Prep machines.  I will then take that and make
minor changes for the 8xx ports.  I am considering throwing out
all of the hacks for the MBX (inet addresses and stuff).  I have
only two goals for the 8xx ports.  One, it should load in a small
memory (less than 4 Meg) configuration.  Two, it should load
from a high memory flash rom address.  I am willing to toss the 4M
goal because I don't think you can do anything useful in that
amount of space (you can't use a ramdisk).


> I'll try upgrading to 2.2.0p7 tonight and see how that works.

I should do that too :-).


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
