Date: Tue, 25 Jul 2000 11:38:12 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, daenzerm@student.ethz.ch,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.10.10007251658390.27756-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0007251134060.1469-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Depends what proble we are talking about.

I have been unable to get anything but 1280x1024 to work correctly for
r128.  The others are deifnetely not be probed correctly but it sounds
like I need a patch which I shall apply and will magically be better :)

For platinumfb I have had no luck either, but I suspect that is just that
I don't have things configed correctly (also will try another monitor
although it works in mac).

				john



On Tue, 25 Jul 2000, Michael Schmitz wrote:

>
> > I didn't follow the thread from the beginning, so I may have missed
> > something. The r128 driver on top of fbdev works nicely for me and all
> > machines I've tested so far (g4 and Pismo). Note however that the stock
>
> The problem was with platinumfb not aty128 IIRC. aty128 worked fine for
> him.
>
> 	Michael
>
>
>

--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
