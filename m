Date: Sun, 22 Aug 1999 18:30:18 -0400
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: lost Button2 in upgrade to 2.2.10
Message-ID: <Pine.SGI.4.00.9908221825100.5682-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I upgraded my G3 450 to 2.2.10 today.  I've been running 2.2.6.

I pulled the keyboard-2.2.10 and mouse-2.2.10 files and linked them in
/etc/sysconfig correctly.

Booted into linux without a problem.

But now Button2 no longer works.  I'm using a Logitech MouseMan Wheel USB 
3 button mouse.

I ran xev to see what Button2 was mapped to.  Button1 shows up as Button1.
Button3 shows up as Button3.  Button2 shows up as nothing.  xev registered
nothing.

Again, all three buttons worked correctly with 2.2.6.

-b


--
AOL SAPI 		                        703.265.0908     AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
