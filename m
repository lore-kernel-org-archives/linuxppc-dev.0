Date: Thu, 4 Feb 1999 14:09:30 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Gary Thomas <gdt@linuxppc.org>
Cc: Michael Meissner <meissner@cygnus.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>, Dan Malek <dmalek@jlc.net>,
        linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.rutgers.edu,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Message-ID: <19990204140930.A1710@wogglebug.cygnus.com>
References: <19990201105850.A1612@wogglebug.cygnus.com> <XFMail.990201161825.gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.990201161825.gdt@linuxppc.org>; from Gary Thomas on Mon, Feb 01, 1999 at 04:18:25PM -0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 01, 1999 at 04:18:25PM -0000, Gary Thomas wrote:
> 
> On 01-Feb-99 Michael Meissner wrote:
> > On Wed, Jan 20, 1999 at 03:21:36PM -0000, Gary Thomas wrote:
> >> I have put up all my patches against 2.2.0p7 at:
> >>   ftp://ftp.linuxppc.org/gary/diffs-2.2.0p7-Jan20
> >> These are diffs against the virgin 2.2.0-pre7.
> > 
> > Over the weekend, I moved the PowerPC to my home, and confirmed Gary's patches
> > do allow me to boot on my Utah machine.  Note, the patch for
> > drives/char/pc_keyb.c won't apply to 2.2.1, but its a simple matter to adjust
> > the patch.
> > 
> 
> I'll re-post these for 2.2.1 later [possibly today], along with a
> couple of others I have.

Note, I went into the office yesterday, and tried my boot disk with Gary's
changes on the older PowerStack-1 I have in the office (603, no L2 cache, 48
meg of non-pairity memory), and it wouldn't boot due to insufficient memory.
As I mentioned, it does boot fine on my PowerStack-II (Utah, 604e, 128 meg of
memory, 512K L2 cache).

> 
> ------------------------------------------------------------------------
> Gary Thomas                              |
> email: gdt@linuxppc.org                  | "Fine wine is a necessity of
>    ... opinions expressed here are mine  |        life for me"
>        and no one else would claim them! |
>                                          |      Thomas Jefferson
> ------------------------------------------------------------------------
> 
> 

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
