Date: Wed, 24 Mar 1999 09:20:12 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel lockups during extended sound playing on PReP BlackHawk
Message-ID: <Pine.LNX.4.04.9903240914510.1747-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a PReP BlackHawk machine with build-in cs4232 audio controller
which has been having lockup problems while playing sound for an extended
period of time.

When the machine locks up, it seems like it's dieing in the interrupt
code, since I get no response from anything (keyboard, serial port,
network). There are no incriminating messages on the serial console. I
can't tell if the main console says anything because it's blanked.

This has happened in vger 2.2.4 and in regular 2.2.1.

This also doesn't happen until sound has been playing for several hours
(via an MP3 player).

does anyone have any idea what might be causeing this, and where to start
adding printk's?

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
