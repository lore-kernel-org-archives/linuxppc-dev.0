Date: Fri, 25 Jun 1999 14:33:23 -0400 (EDT)
From: Colin Fredericks <fredec@rpi.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac sound problems
Message-ID: <Pine.A41.3.96.990625141549.25298A-100000@cortez.sss.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone.  I currently have LinuxPPC R5 installed on my rev. A iMac
(233 Mhz processor, 6 megs of VRAM (upgraded from 2), 96 megs of ram). 
I've had a few problems (to be expected), but only one that I felt I
should bring to the developer list: 

Sound in the basic setup is bletcherous.

Something (whether it be in KDE or Enlightenment or something more basic) 
is trying to write sound directly to my speakers. It ignores any line-out
or headphones plugged in.  System and error sounds create the same kind of
beautiful sound you get when trying to shift into reverse from 3nd gear
because you overshot 4th gear. This happens about 80% of the time, with
the system sounds continuing to play even after the "enable sound in
Enlightenment" and "KDE sounds" are turned off.

Such applications as x11amp do read MP3's correctly, and play correctly.
However, they also write directly to the speakers. :(

I'm not on the list, so anyone with suggestions should e-mail me at
fredec@rpi.edu. Thanks for everyone's work with LinuxPPC - great product.

		-Colin Fredericks


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
