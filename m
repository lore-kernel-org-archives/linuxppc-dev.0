Date: Fri, 5 Mar 1999 16:08:16 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problem in pre-R5
In-Reply-To: <Pine.LNX.4.05.9903042200281.16485-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.4.05.9903051607040.23617-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 Mar 1999, Tom Rini wrote:

> On Fri, 5 Mar 1999, Martin Costabel wrote:
> 
> > Tom Rini wrote:
> > > 
> > > On Thu, 4 Mar 1999, Martin Costabel wrote:
> > > 
> > > > Does anyone else see this?
> > > 
> > > used to. Upgrade ncurses as well.
> > 
> > Thanks. Just upgraded; still doesn't work. What version of ncurses is
> > recommended?
> 
> Gimmie a few.. <g>  I'm looking at a few things now.

It's been a few, fix found.  For those of you that just can't wait/use
less, grab util-linux 2.9i and change HAVE_SHADOW=yes to no (current
behavior) and build.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
