Message-ID: <36DB06D2.37D6F0AC@jps.net>
Date: Mon, 01 Mar 1999 13:29:54 -0800
From: Keith Clayton <kclayton@jps.net>
Reply-To: kclayton@jps.net
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: /* Vinai */ <vroopcha@post.its.mcw.edu>, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: fixes in glibc ??
References: <Pine.LNX.4.05.9903011518390.10454-100000@pc.wackyland.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You're right, I do read a bit too much /. <g>  

I'm glad to hear glibc2.1 is still alive and well.  I assumed (yes I
know the saying around "assume" though I didn't follow it in this case .
. smile . .) that gnu had much more of a say in glibc's distribution
than it appears (it being the gnu C library) . . especially when Jason
wrote about glibc2.1 being pulled.  So, I apologize for any FUD I've
stirred into the mix.

One thing I did want to bring out with this though, is that
Linux/PPC.com (that include you Tom, right?) is in many cases dealing
with situations that aren't totally under its control.  Glibc
development, while facilitated by those of you at linuxppc.com working
on glibc, is not totally in your hands.  You guys don't necessarily have
the final say as to when its ready for prime time or not.  I've got a
spare hd right now begging for r5 but I strongly respect linuxppc.com's
desire to ship a product that works right (ooo. . novel concept . .
apple . . m$ are you listening?).  If I needed it that bad, I could grab
pre-r5 or, for that matter, cobble together my own system.

So, I guess in my usual longwinded way, my point beyond glibc2.1 was
that r5 is not a completely inhouse type project, ala Apple or M$. 
Schedules are not determined by linuxppc.com but rather by progress on
the various projects by the community as a whole.  We all need to keep
that in mind while we "wait patiently" for r5.


Keith Clayton
kclayton@jps.net
Tom Rini wrote:
> 
> /me runs about screaming
> 
> On Sat, 27 Feb 1999, Keith Clayton wrote:
> 
> > I can't comment on what the current state of glibc 2.0.xxx is but we
> > should clarify something for the sake of the Linux/PPC people (Jason, et
> > all).  glibc2.1 is not being pulled from r5 alone.  glibc2.1 was
> 
> Right, it's not being pulled from anything.
> 
> > completely pulled from distrubtion on ANY platform by gnu due to licensing
> > problems with one section of code written by people outside gnu.  They
> > put a license restriction on their section of code that was a bsd style
> > license, which conflicts with the GPL.  As a result GNU pulled glibc2.1
> 
> You read too much /. <g>.  The section in question has been in glibc for a
> long time (2.0.x anyways iirc) and has special permission to be included.
> 
> > from their site.  The ability or inability to include glibc2.1 in r5 is
> > not a linuxppc.com decision at this point in time.  From posts I've read
> > it seems that many have misinterpreted Jason's post to mean that
> > linuxppc.com chose not to include glibc2.1.  I'm not privy to their
> > decision making process but in this case, glibc2.1 is being pulled by a
> > "higher power"  Please no flames as to the assention of RMS to higher
> > power status (smile)
> 
> No no no, god no.  glibc 2.1 can be included in anything.  glibc is not on
> ftp.gnu.org for purely political reasons.  It is however avail from other
> places (ie redhat has a 2.1 SRPM, iirc) like
> ftp://sourceware.cygnus.com/pub/glibc/glibc-2.1.tar.gz and I think
> ftp.funet.fi has it as well.  R5 can and will include glibc 2.1. Of
> course, I'm just a developer, but there's no reason not to use it (and
> there's nothing else we can use.  Those glibc 2.0.108-1c RPMs have that
> "bad" code as well).
> 
> ---
> Tom Rini (TR1265)
> http://dobbstown.yeti.edu/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
