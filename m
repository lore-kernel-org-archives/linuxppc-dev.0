Date: Thu, 21 Jan 1999 19:04:24 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Michael Meissner <meissner@cygnus.com>
cc: Johnnie Peters <jpeters@phx.mcd.mot.com>, Gary Thomas <gdt@linuxppc.org>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        Dan Malek <dmalek@jlc.net>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <19990121205232.A10305@wogglebug.cygnus.com>
Message-ID: <Pine.LNX.3.96.990121190157.466A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The changes are not minor.  I'm going to hold off for a while.

arch/ppc/boot needs to be redone anyway so until that happens (which
should happen soon) I think it best to wait.  

My current thinking is that there will be a arch/ppc/prepboot for prep and
a arch/ppc/8xxboot for the 8xx processor systems (mbx, rpx lite and so
on).  prepboot will likely be based on Gabriels prepboot code.  Those are
just my rough ideas right now so they're subject to change.  Anyone have
suggestions or opinions about that?

}I suspose it is too late to get this in the real 2.2.0 release?


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
