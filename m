Date: Tue, 20 Jul 1999 09:25:33 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: X : caught signal 11 ?
In-reply-to: <Pine.LNX.3.96L.990720100907.1737B-100000@unix47.andrew.cmu.edu>
To: Hollis R Blanchard <hollis+@andrew.cmu.EDU>
Cc: Yann Bizeul <yann@tynsoe.COM>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990720092348.538970380F-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I switch on and off all the time (I have 6 console VT's and 2 X
VT's). I used to get palette problems, but not since I applied anthony
tong's patch and rebuilt X. It never died (well, it did in my cobbled
pre-R5, but not in the released LinuxPPC 1999).

On Tue, 20 Jul 1999, Hollis R Blanchard wrote:

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
> 
> To crash X:
> startx
> ctrl-cmd-F1
> 
> Poof. All gone. If you have xdm set up, xdm reloads (and takes you to vc 7
> from wherever you wanted to go in the first place). I'm using platinumfb. Is
> anyone else out there able to use virtual consoles without X crashing?
> 
> -Hollis
> 

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
