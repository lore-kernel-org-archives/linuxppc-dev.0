Date: Sun, 06 Aug 2000 18:15:00 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Multi-head on Pismo
To: linuxppc-dev@lists.linuxppc.org
Message-id: <854304.3174574500@[209.147.134.131]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been playing around recently trying to get multi-head support on my
Pismo laptop to work.  This is using the built-in VGA port along with the
LCD.  I have a few questions/comments.  Currently, I'm using XF86 4.0.1
with the r128 driver and kernel 2.2.17pre10-ben2.

I have tried simply modifying the ServerLayout in the XF86Config file, but
this will not work (I don't think) since both the VGA port and the LCD are
run off the same Rage128 chip.  All examples I have seen of using Xinerama
to do this have used 2 sepearte cards.  I'm using the command 'startx --
+xinerama' to start X.

When the machine boots, a message pops up on the external message as
follows:

...ok
Copying OF device tree...done
Initing fake screen
Calling quiesce

then the screen goes black and remains that way for the session.  What does
this mean?


(Possible OT) Another thing I noticed while poking around in the device
tree is that there are two ATY,RageM3p entries under
/proc/device-tree/pci/ATY,RageM3pParent.  They are pA and pB.  What do
these two have to do with each other?

Has anyone else out there worked on this, and (hopefully) gotten it to work
right?  Thanks for any help you can give.

Tim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
