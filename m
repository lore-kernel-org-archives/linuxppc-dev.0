Date: Mon, 1 Mar 1999 15:23:50 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Keith Clayton <kclayton@jps.net>
cc: /* Vinai */ <vroopcha@post.its.mcw.edu>, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: fixes in glibc ??
In-Reply-To: <Pine.LNX.3.96.990227133305.936A-100000@localhost>
Message-ID: <Pine.LNX.4.05.9903011518390.10454-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


/me runs about screaming

On Sat, 27 Feb 1999, Keith Clayton wrote:

> I can't comment on what the current state of glibc 2.0.xxx is but we
> should clarify something for the sake of the Linux/PPC people (Jason, et
> all).  glibc2.1 is not being pulled from r5 alone.  glibc2.1 was

Right, it's not being pulled from anything.

> completely pulled from distrubtion on ANY platform by gnu due to licensing
> problems with one section of code written by people outside gnu.  They
> put a license restriction on their section of code that was a bsd style
> license, which conflicts with the GPL.  As a result GNU pulled glibc2.1

You read too much /. <g>.  The section in question has been in glibc for a
long time (2.0.x anyways iirc) and has special permission to be included.

> from their site.  The ability or inability to include glibc2.1 in r5 is
> not a linuxppc.com decision at this point in time.  From posts I've read
> it seems that many have misinterpreted Jason's post to mean that
> linuxppc.com chose not to include glibc2.1.  I'm not privy to their
> decision making process but in this case, glibc2.1 is being pulled by a
> "higher power"  Please no flames as to the assention of RMS to higher
> power status (smile)

No no no, god no.  glibc 2.1 can be included in anything.  glibc is not on
ftp.gnu.org for purely political reasons.  It is however avail from other
places (ie redhat has a 2.1 SRPM, iirc) like
ftp://sourceware.cygnus.com/pub/glibc/glibc-2.1.tar.gz and I think
ftp.funet.fi has it as well.  R5 can and will include glibc 2.1. Of
course, I'm just a developer, but there's no reason not to use it (and
there's nothing else we can use.  Those glibc 2.0.108-1c RPMs have that
"bad" code as well).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
