Message-ID: <19990208104605.3603.qmail@www0i.netaddress.usa.net>
Date: 8 Feb 99 10:46:05 GMT
From: Simon Stapleton <s.stapleton@usa.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Wacom tablet woes, Xfree86
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

I've been trying to get some support for my Wacom tablet under LinuxPPC
(Release 4, 2.130 kernel), with little to no success.  'Out of the box', the
tablet only works in 'relative' mode, and the buttons my puck all return
button 1 events.

I've tried the various 'mousemode' commands, but the tablet refuses to budge
from handler 58. Quite what this signifies, I have no idea.

I downloaded and installed Xfree86 3.3.3, as it has a wacom driver.  Of
course, this doesn't work.  The 'mouse' section works fine, albeit with only
one button, as before, but the Xinput driver assumes a PC Wacom tablet
connected to a serial port.  And mine, of course, is an ADB model.
Xinput complains when trying to initialise the tablet, complaining that the
device is 'not a TTY'.

So, I guess I'm going to have to start hacking.  My question, however, is
this...

If I put support into the xinput driver, re-initialising the tablet etc, will
extended information such as tilt and pressure be trapped and dumped by the
kernel, which only seems to recognise the tablet as a basic one-button mouse? 
Do I need to hack the kernel as well?  I'm not entirely sure how all the
drivers hang together (I'm only starting coding under linux, although I have
many years of commercial 'C' experience.  This will be a first real 'in the
guts of the beast' experience.).

I assume that If I start hacking the kernel as well, I ought to move up to the
new 2.2 tree.  Which adds a whole new level of complexity. Heh.

Anyway, TIA for any help or guidance

Simon

____________________________________________________________________
Get free e-mail and a permanent address at http://www.netaddress.com/?N=1

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
