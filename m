Date: Tue, 20 Jul 1999 10:13:16 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Yann Bizeul <yann@tynsoe.com>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: X : caught signal 11 ?
In-Reply-To: <199907200828.DAA31764@lists.linuxppc.org>
Message-ID: <Pine.LNX.3.96L.990720100907.1737B-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Jul 1999, Yann Bizeul wrote:
> 
> I've a little bit more informations.
> 1) X caught signal 11 and quits each time I go back to a console.
> 2) X quits each time XScreensaver is launching
> 
> Iuse the XFree server provided by Release 5

I also have problem 1), though I guess I've managed to disable xscreensaver so
X does its built-in blanking thing (with no power saving =( ).

To crash X:
startx
ctrl-cmd-F1

Poof. All gone. If you have xdm set up, xdm reloads (and takes you to vc 7
from wherever you wanted to go in the first place). I'm using platinumfb. Is
anyone else out there able to use virtual consoles without X crashing?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
