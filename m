Date: Mon, 27 Aug 2001 14:51:38 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Dan Malek <dan@mvista.com>, jpeters@mvista.com,
	John Tyner <jtyner@cs.ucr.edu>
Subject: Re: ppc405 enet changes (moving thread from commit)
Message-ID: <20010827145138.D10302@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just moving a thread over from the commit mailing list on changes to
the 405GP ethernet driver.

----- Forwarded message from andrew may <acmay@acmay.homeip.net> -----
On Mon, Aug 27, 2001 at 06:34:35PM -0400, Dan Malek wrote:
> andrew may wrote:
>
> > The COMMAC can handle packets that are across multiple buffer descriptors.
>
> Sure, most contemporary hardware can do this.
>
> > So the ethernet hardware should be able to handle skb frags.
>
> Have you ever seen these?  You certainly don't get them for transmit.

Well you have to set dev->features to get them otherwise the net core
will call skb_linearize and you will never see them. Then you have to
have something in the stack generate them, like sendfile.


----- End forwarded message -----

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
