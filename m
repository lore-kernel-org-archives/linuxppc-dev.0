Date: Mon, 4 Mar 2002 19:53:28 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
Message-ID: <20020304195328.B15551@ecam.san.rr.com>
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu> <3C7D0AB9.5070801@pacbell.net> <20020304131703.A15551@ecam.san.rr.com> <3C838533.6050603@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C838533.6050603@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 04, 2002 at 02:31:15PM +0000, Armin wrote:
> andrew may wrote:
> > On Wed, Feb 27, 2002 at 04:35:05PM +0000, Armin wrote:
> >
> >>Thanks,
> >>
> >>I want to try in on a few boards I have before it goes in.
> >>
> >>--armin
> >>
> >
> > Have you gotten a chance to try it yet? The testing I have
> > done has not shown any problems and I have been able to test
> > just about all of the cases. Boards with/without the correct
> > pull-ups. Remove the correct phy-id from the table. Booting
> > without a link.
> >
> > Here is another patch that for the driver. It removes some
> > cut and paste code from the rx interupts and breaks the work
> > into rx_clean and rx_fill functions. rx_fill is also called from
> > open.
> >
>
>
> Yes I have.
>
> I added history info and sent it to Tom to check in.

Thanks
>
> I will look into this patch and will try it after Tom gets done.

Well I just noticed that building as a module is pretty far from
working at the moment. Are there any plans to fix this? I am not
sure how to cleanly get this working since there are all sorts of
exports/externs that need to be fixed up. The tulip driver should
be a good example, but it is broken off into it's own dir and I
don't know if we want to do this for the ocp_enet as well.

I can resend with a .h change and config.in change to pull the
skb_res value out as a build option, but I want to see if anyone
has any other comments before hand.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
