Message-ID: <37158D29.132CCFC1@wanadoo.fr>
Date: Thu, 15 Apr 1999 08:54:33 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
References: <Pine.LNX.4.05.9904141910410.487-100000@pc.wackyland.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> Hmm.  I don't use gnuplot (and thus didn't see the bug and don't have the
> source handy), so if any x86/Linux users with glibc 2.1.x installed could
> see if they run into the bug..

When gnuplot-3.7 came out, this problem was mentioned to one of the
gnuplot discussion groups (which I don't normally read, I use gnuplot
only occasionally, with octave, for example). It didn't get much
attention, because it seems to affect only linuxppc (and who's using
that, anyway?)
 
> > Or could someone find out what's wrong with the fprintf function in
> > LinuPPC? Note that this is not specific for one version of glibc. I
> > tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.
> 
> It failed under the old libs?

Yes, I compiled gnuplot-3.7 under glibc-961212 (rev 1o, IIRC), and the
result was the same. I managed to track the problem down to the fprintf
call, but I don't know enough C and glibc to go any further.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
