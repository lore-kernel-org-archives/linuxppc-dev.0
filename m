Message-ID: <19981209200520.A7128@bleck.ksu.ksu.edu>
Date: Wed, 9 Dec 1998 20:05:20 -0600
From: Zach Metzinger <wizkid@ksu.edu>
To: Randy Gobbel <gobbel@andrew.cmu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: New XF68_FBDev
References: <Pine.LNX.4.03.9812041504560.26444-100000@mercator.cs.kuleuven.ac.be> <ML-3.4.913235228.9383.gobbel@gamera.psy.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ML-3.4.913235228.9383.gobbel@gamera.psy.cmu.edu>; from Randy Gobbel on Wed, Dec 09, 1998 at 03:27:08PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 09, 1998 at 03:27:08PM -0500, Randy Gobbel wrote:
> 
> Using XF68_FBDevv-accel-ppc-19981204-2, I'm seeing some trashed pixels when
> doing solid window moves and when scrolling, at both 8 and 16 bpp.  It looks to
> me like the BITBLTs are picking up bits from the framebuffer rather than from
> the window.  xrefresh puts things back in order.

Well, bitblt's do pick up bits from the framebuffer and not from the system
memory. That's why it's called acceleration, the video card's graphics
engine does the moving of data within the framebuffer memory on behalf of
the X server. No idea why it does this, however, since -accel-ppc exits
on signal 11 (Segv) on my machine.

--- Zach

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
