Message-Id: <3.0.5.32.19990802114406.00817210@mailhost.bulldog.com>
Date: Mon, 02 Aug 1999 11:44:06 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Joe Julicher <joe_julicher@macktrucks.com>
Subject: Sound
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if this has been covered yet but I have some sound questions.
(pun not intended)

I was playing with X11amp and later XMMS and noticed that there are
significant freezes in the system while the sound is playing.  For example,
if you press the button on the tool panel of gnome that retracts the panel,
it will typically retract, and play the whoosh sound.  But when you try to
extend the panel, it will freeze for a bit, and then play.  It is only
while sound is playing.  I don't think it is the X11amp software (or the
XMMS) because the xload stays low (very low).  I fiddled with the OSS
buffer sizes in the X11amp preferences but did not see any change.  XMMS
works better (the displays update in real time) but still has the pauses.
Other programs that do not depend on sound still seem to work fine and are
not paused.

System: Rev 1 G3 292mhz
	160 Mb RAM
	14 GB IDE drive

Thanks,
Joe Julicher

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
