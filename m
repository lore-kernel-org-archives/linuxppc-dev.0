Message-ID: <87009604743AD411B1F600508BA0F95994CEA3@XOVER.dedham.mindspeed.com>
From: "Clayton, Mark" <mark.clayton@netplane.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: starting with Linux on EST SBC8260 (getting a little OT)
Date: Thu, 14 Feb 2002 16:25:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Langus Matevz RDHW_EXT wrote:
>
> > I would like to ask you, how much effort would it be
> required to get Linux
> > running on EST SBC8260. Since this is a very widely used
> board, probably a
> > lot of peope have already ported Linux on it.
>
> I ported it a long time ago.  It's part of the kernel sources.  Don't
> try to use the EST tools, though.  I don't know if they have
> a boot rom
> for that board yet, but I suspect you can flash PPCBoot with
> the EST tools
> and then throw them away.
>
> >
> > Is there a step-by-step guide what should be
> compiled/installed/done to get
> > it running?
>
> I don't know if the MontaVista Journeyman kits are around
> anymore, but it
> was supported and documented in there.
>
> You could also search the PPCboot (and these) archives for
> information.
>
> The board was more popular a couple of years ago when it was
> one of the
> first ones around.  Lots of other, easier to use boards are
> available now,
> for less money.  My EST boards became non-functional long
> ago, and they are
> on the scrap heap.

What boards are people using these days then?  I'm in need of a
new PPC board with 2 or more ethernet interfaces.  Unfortunately,
I need a board that has VxWorks and OSE BSPs as well.

Does anyone have any suggestions?

Many thanks,
Mark

>
> Good luck.
>
>
> 	-- Dan
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
