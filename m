Date: Tue, 22 Jun 1999 11:11:51 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
To: linuxppc-users@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: [workaround] console-switch screws colors
In-Reply-To: <199906220307.NAA01278@farrago.anu.edu.au>
Message-ID: <Pine.LNX.3.95.990622110721.4570A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

i've noticed (at least) with a couple of machines that use ati graphics
that switching away from and back to X screws up the colors (using xfb). 
fortunately, i left it that way long enough for the screensaver to kick in
and realize it was fixed by the screensaver!

so if you switch back to x and the colors are screwed, invoke the
screensaver:

 xset s activate

hopefully this is one of those things that will be fixed soon anyway.

Brad
brad@pht.com | http://www.pht.com/~brad/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
