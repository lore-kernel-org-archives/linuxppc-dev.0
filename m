Message-ID: <3794D221.149CF3FC@wanadoo.fr>
Date: Tue, 20 Jul 1999 21:46:41 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@disparity.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the vger 2.2 kernel branch dead
References: <Pine.BSF.3.96.990720135224.50420R-100000@silver.teardrop.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Tue, 20 Jul 1999, Neil Piercy wrote:
> 
> > From: Tom Rini <trini@disparity.net>
> >
> > > On Mon, 19 Jul 1999, Johnnie Peters wrote:
> > >
> > > Try putting 'em vs 2.3.x.  I think right now the push is to fix all the
> > > little annoyances/problems that we're stuck w/ in 2.2.x and move forward
> > > in 2.3.x.  Then backport things later on.
> >
> > I thought 2.2.x was meant to be the stable branch and 2.3.x the dev ?  It
> > seems strange to back-port fixes to known bugs in the stable branch from a
> > dev branch which is frequently broken - or do I misunderstand ? Stable
> > doesnt equal frozen in my book.
> 
> 2.2.x is for obvious and correct stuff, important fixes and the like.
> Some of the stuff no doubt belongs in 2.2.x.  Other things I've seen go
> past (Hotswap PCI) is most definatly a 2.3.x thing (IMHO) and might need
> some work to be accepted by linus (as hotswap is a generic thing, but i
> didn't look over that patch very well).  Of course another problem is
> making sure Cort or Paul actually sees the patch and doesn't accidently
> just delete it.  I know Cort gave some people who asked accounts on
> linuxppc.cs.nmt.edu for patches, and I think there's a place anyone can
> upload...

Is anyone in the PPC camp actually following the vger 2.3.x branch? I am
asking because since almost a month this branch hasn't compiled on my
ppc any more, due to some obvious bugs. Maybe it is better to wait until
the dust from that page-cache adventure has settled? 

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
