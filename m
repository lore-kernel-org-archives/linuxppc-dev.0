Date: Thu, 11 May 2000 11:07:39 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: jeramy b smith <ultrapenguin@netscape.net>
cc: chris mccraw <chrism@brahma.ticam.utexas.edu>,
        Bernhard Reiter <bernhard@intevation.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
In-Reply-To: <20000511001504.11506.qmail@www0p.netaddress.usa.net>
Message-ID: <Pine.LNX.4.10.10005111102470.4724-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > i've done some reasonably big compiles and run seti@home at the same time.
> > however i've never kept at it for excessive periods of time...i'll leave a
> > kernel make looping tonight building off an nfs disk to the local disk
> > and see if anything turns up by morning...
>
> I have left my lombard running for 4 days in a row which included several
> sleeps. During this period I did a 6 hour stint playing with the development
> kernel code and did about 20 makes. No problems and this was after I bumped it
> up to 192. I could try building GRASS just to empirical though.

Seems there's more people successfully running >64M in their Lombard here
than it first seemed. Someone pointed to the kernel problem corner, so
what kernel versions were these success stories run on?

(Mine's some old 2.2.13, 2.2.15pre9, 2.3.48 and 2.3.99pre6)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
