Message-ID: <37949F61.86599E37@adrenalin.com>
Date: Tue, 20 Jul 1999 09:10:09 -0700
From: Chris Baker <cbaker@adrenalin.com>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: X : caught signal 11 ?
References: <Pine.LNX.3.96L.990720100907.1737B-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:

> On Tue, 20 Jul 1999, Yann Bizeul wrote:
> >
> > I've a little bit more informations.
> > 1) X caught signal 11 and quits each time I go back to a console.
> > 2) X quits each time XScreensaver is launching
> >
> > Iuse the XFree server provided by Release 5
>
> I also have problem 1), though I guess I've managed to disable xscreensaver so
> X does its built-in blanking thing (with no power saving =( ).

I'm assuming you mean something along the lines of

$ xset s off

Does X have a built in blanking thing other than that?  Or is it an Apple hardware
thing?

>
>
> To crash X:
> startx
> ctrl-cmd-F1
>
> Poof. All gone. If you have xdm set up, xdm reloads (and takes you to vc 7
> from wherever you wanted to go in the first place). I'm using platinumfb. Is
> anyone else out there able to use virtual consoles without X crashing?

I can switch consoles o.k. I'm on a pb3400c so I guess that makes me chips65550fb
(?).  If I put the machine to sleep for any significant period of time, X dies.

Is this just an xfree problem or is it in xpmac also?

cheers,

cbb



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
