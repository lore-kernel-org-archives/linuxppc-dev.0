Date: Wed, 17 Feb 1999 11:49:53 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Andreas Tobler <toa@pop.agri.ch>
cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: back to gcc under pre-R5
In-Reply-To: <36CAED45.D35789FD@pop.agri.ch>
Message-ID: <Pine.LNX.4.05.9902171148190.7316-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Feb 1999, Andreas Tobler wrote:

> Tom Rini wrote:
> > 
> > 
> > What bug are you running into?  It's better to get 'em fixed now then try
> > to work around 'em...
> > 
> 
> When you have a look at page from John Lindal: http://www.cco.caltech.edu/~jafl/jx/jx2.html
> There it explains the bug I ran/run into when I built JX.
> Unfortunately there is no solution in sight from egcs people (as I understand)

Ah.  Well, either find out from John Lindal which files are effected by
this bug and compile those with -fno-vtable-thunks, or compile the whole
program with that.  Don't need to recompile libstdc++ or anything else.
(just checked with his testcase).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
