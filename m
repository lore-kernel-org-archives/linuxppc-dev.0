Date: Tue, 20 Jul 1999 13:56:21 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Neil Piercy <npp1@scigen.co.uk>
cc: Johnnie Peters <jpeters@phx.mcd.mot.com>, Matt Porter <mmporter@home.com>,
        VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the vger 2.2 kernel branch dead
In-Reply-To: <026501bed2d7$042f4180$232cd8c2@scigen.co.uk>
Message-ID: <Pine.BSF.3.96.990720135224.50420R-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Jul 1999, Neil Piercy wrote:

> From: Tom Rini <trini@disparity.net>
> 
> > On Mon, 19 Jul 1999, Johnnie Peters wrote:
> >
> > Try putting 'em vs 2.3.x.  I think right now the push is to fix all the
> > little annoyances/problems that we're stuck w/ in 2.2.x and move forward
> > in 2.3.x.  Then backport things later on.
> 
> I thought 2.2.x was meant to be the stable branch and 2.3.x the dev ?  It
> seems strange to back-port fixes to known bugs in the stable branch from a
> dev branch which is frequently broken - or do I misunderstand ? Stable
> doesnt equal frozen in my book.

2.2.x is for obvious and correct stuff, important fixes and the like.
Some of the stuff no doubt belongs in 2.2.x.  Other things I've seen go
past (Hotswap PCI) is most definatly a 2.3.x thing (IMHO) and might need
some work to be accepted by linus (as hotswap is a generic thing, but i
didn't look over that patch very well).  Of course another problem is
making sure Cort or Paul actually sees the patch and doesn't accidently
just delete it.  I know Cort gave some people who asked accounts on
linuxppc.cs.nmt.edu for patches, and I think there's a place anyone can
upload...

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
