Message-ID: <3909892A.41387BC1@uncc.edu>
Date: Fri, 28 Apr 2000 08:50:50 -0400
From: root <whschult@uncc.edu>
MIME-Version: 1.0
To: Michel Ddnzer <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Latest XFree86 v4.0 crashing (possible culprit sawmill)
References: <200004270502.AAA08920@lists.linuxppc.org>
            <39090775.BFEECFA1@uncc.edu> <39092CEA.1321BC79@student.ethz.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> root wrote:
>
> > While switching desktops, X completely dies on me.  It's not
> > consistently repeatable, but I've had to kill the programs it didn't
> > pull with it enough times to know that something's wrong.
> >
> > That's all it's doing.  X dies when I'm switching desktops, either by
> > dragging the mouse, or by clicking the desktop in the deskguide.
>
> Just to be sure: Is this about "real" desktops or virtual desktops? AFAIK
> mouse dragging only works to switch between virtual ones?
>
>
> > Please tell me I'm crazy and that it isn't really happenning...
>
> You're crazy and it isn't really happening. *grin*
>
> Seriously, Sawmill isn't the culprit (Listen people: server crashes are
> _never_ application bugs :) but it seems to point out this server bug better
> than anything else.
>
> If you could provide a gdb backtrace from a static server, that would be
> great, otherwise you could send the log and other useful information either
> here or maybe better to XFree86.
>
>
> Michel


I'm roughly familiar with gdb, but not enough to really know what I
should be doing to help.  Where should I expect to find the core file,
and what information do you need?  Which log file do you need?


Hank

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
