Date: Wed, 9 Dec 1998 15:27:08 -0500 (EST)
From: Randy Gobbel <gobbel@andrew.cmu.edu>
Reply-To: Randy Gobbel <gobbel@andrew.cmu.edu>
Subject: Re: New XF68_FBDev
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org, Randy Gobbel <gobbel@andrew.cmu.edu>
In-Reply-To: <Pine.LNX.4.03.9812041504560.26444-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <ML-3.4.913235228.9383.gobbel@gamera.psy.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Using XF68_FBDevv-accel-ppc-19981204-2, I'm seeing some trashed pixels when
doing solid window moves and when scrolling, at both 8 and 16 bpp.  It looks to
me like the BITBLTs are picking up bits from the framebuffer rather than from
the window.  xrefresh puts things back in order.

Any particular thing you'd like me to try out?  The simulation I've been
beating my head against for the last several months finally started working, so
I may have a little more time to hack on Linux stuff for a while.

-Randy


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
