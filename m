Message-ID: <374AA46D.A1A4BAFC@americasm01.nt.com>
Date: Tue, 25 May 1999 09:23:57 -0400
From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
To: Mark Abene <phiber@radicalmedia.com>
CC: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: turbo mouse driver fix...
References: <19990525024524.D26885@radicalmedia.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark Abene wrote:
> 
> Hey!  Please test the following patch to mac_keyb.c which fixes the TurboMouse
> support you added based on my "mousehack" program.  I tested my changes on a
> 2.2.7 kernel.  The problem is that once you determine we are working with a
> TurboMouse 5 (thanks for adding the reg 1 ID detection, btw!), we need to write
> to id 3, which is how you control the TurboMouse 5's modes, not to id 15.

Naive question here:  Does id 3 refer to the adb device?  The reason I
ask is that when I had the 2.2.0/1 kernel, 3-button detection wasn't
working properly in my setup.  At the time the answer was supposed to be
running 

mousemode 3 4

However, in my setup I also had a joystick connected.  So in reality I
sometimes had to do mousemode 15 4 randomly.  I guess it was whichever
device got recognized first.

Anyway, my point is that if this is the device id, assuming id 3 may not
be the correct thing to do in general.

If it's not device id, just ignore me :-)

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
