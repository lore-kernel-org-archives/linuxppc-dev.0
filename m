Date: Sat, 26 Dec 1998 23:59:04 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: fbcon + X Server + Cirrus/Powerstack
Message-ID: <Pine.BSI.3.96.981226234556.25149A-100000@usr09.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a couple problems using X Servers with the clgenfb framebuffer
console on the Motorola Powerstack and was wondering if anyone else had
similar problems with other framebuffers/X Server combinations.  I have the
clgenfb console as the only console in the kernel right now, and it works
fine as a console.

1) When I try to use XF68_FBDev from the XFree 3.3.3 binaries, I get a while
screen.  However, everything seems to be running fine -- the window manager
and X Server, etc are included in the list of running processes. My first
guess is the XF86Config file, but it could be something else.  Where isa
good location to get a simple, basic XF86Config file that defaults to  
640x480x8 or similar?  (Or if you have a clue that it could be another
problem with something in the clgenfb driver to look at?)

2) I can run Xbh normally, and exit it back to the framebuffer console.
However, the 1st time I run Xbh, the cursor is garbage (basically a large
square, but not all the bits are set).  When I quit Xbh and run it again,
the cursor looks normal.

3) If I set the console to 1024x768, I get a lot more rows on the screen.
However, if I run gpm, it doesn't allow me to highlight text on the entire
screen -- I think it only allows it on the original 80 column by 24 (?) row
size.  Has anyone fixed this or looked into it yet?

Thanks for any pointers/assistance/etc.  

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
