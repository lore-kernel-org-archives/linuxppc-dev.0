Message-ID: <36A89684.F8E70915@phx.mcd.mot.com>
Date: Fri, 22 Jan 1999 08:17:24 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>, Dan Malek <dmalek@jlc.net>,
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Michael Meissner <meissner@cygnus.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
References: <XFMail.990122075441.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I find that this also would be a great plus as they are needed for
the Utahs.

Johnnie


Gary Thomas wrote:

> On 22-Jan-99 Cort Dougan wrote:
> >
> > The changes are not minor.  I'm going to hold off for a while.
> >
>
> What about the fixes for the PS/2 mouse?  These are not large, but
> significant for systems that need to intialize the mouse from scratch.
>
> > arch/ppc/boot needs to be redone anyway so until that happens (which
> > should happen soon) I think it best to wait.
> >
> > My current thinking is that there will be a arch/ppc/prepboot for prep and
> > a arch/ppc/8xxboot for the 8xx processor systems (mbx, rpx lite and so
> > on).  prepboot will likely be based on Gabriels prepboot code.  Those are
> > just my rough ideas right now so they're subject to change.  Anyone have
> > suggestions or opinions about that?
> >
> > }I suspose it is too late to get this in the real 2.2.0 release?
> >




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
