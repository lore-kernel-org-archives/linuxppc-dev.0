Return-Path: <hbruegge@rockwellcollins.com>
Received: from fw01.rockwellcollins.com (fw01.rockwellcollins.com
	[205.175.225.1]) by ozlabs.org (Postfix) with ESMTP id 191C667A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 18:38:50 +1000 (EST)
From: <hbruegge@rockwellcollins.com>
Received: from vs02.rockwellcollins.com (localhost [127.0.0.1])
	by localhost.rockwellcollins.com (Postfix) with ESMTP id 14D9531884
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 03:08:55 -0500 (CDT)
Received: from crnotes2.rockwellcollins.com (crnotes2.rockwellcollins.com
	[131.198.64.109])
	by vs02.rockwellcollins.com (Postfix) with ESMTP id EBD0C3187B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 03:08:54 -0500 (CDT)
To: linuxppc-embedded@ozlabs.org
Subject: Using RS232 Terminal as input device
MIME-Version: 1.0
Message-ID: <OF62BECBA0.4F3D8E04-ONC1257185.00247B21-C1257185.002CC13C@rockwellcollins.com>
Date: Tue, 6 Jun 2006 10:08:51 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 002CC12AC1257185_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 002CC12AC1257185_=
Content-Type: text/plain; charset="US-ASCII"

Hi all


I am using the kernel (2.6.15) in an ppc-based embedded system through a 
serial console on ttyS0 with no problems.

Now I attached a graphic card to the system, which is correctly 
recognized and initialised by the Kernel. If I add "console=tty0 
console=ttyS0,57600" to the bootargs, I have the boot messages of the 
kernel on the screen and a login on the ttyS0.

What I now want to do is to disable the serial console and use the 
graphic card as output and the raw character data (ASCII) coming in from 
the terminal connected to the rs232 as input.

I have a login on the screen, if I delete the line console=ttyS0,57600 
from the bootargs, but unfortunately no input if a key is pressed on the 
terminal keyboard.


So my problem and question is, apart from not totally understanding the 
input device system of 2.6.x ;-)
Has anyone ever done that?
Is it just a kernel configuration problem? If so what modules have to be 
compiled in?
Are there any good documentaion about the new input device system ?

Basically I am totally confused ;-), so any ideas are appreciated.

Cheers

Harald

--=_alternative 002CC12AC1257185_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>Hi all<br>
<br>
<br>
I am using the kernel (2.6.15) in an ppc-based embedded system through
a <br>
serial console on ttyS0 with no problems.<br>
<br>
Now I attached a graphic card to the system, which is correctly <br>
recognized and initialised by the Kernel. If I add &quot;console=tty0 <br>
console=ttyS0,57600&quot; to the bootargs, I have the boot messages of
the <br>
kernel on the screen and a login on the ttyS0.<br>
<br>
What I now want to do is to disable the serial console and use the <br>
graphic card as output and the raw character data (ASCII) coming in from
<br>
the terminal connected to the rs232 as input.<br>
<br>
I have a login on the screen, if I delete the line console=ttyS0,57600
<br>
from the bootargs, but unfortunately no input if a key is pressed on the
<br>
terminal keyboard.<br>
<br>
</tt></font>
<br><font size=2><tt>So my problem and question is, apart from not totally
understanding the input device system of 2.6.x ;-)</tt></font>
<br><font size=2><tt>Has anyone ever done that?</tt></font>
<br><font size=2><tt>Is it just a kernel configuration problem? If so what
modules have to be compiled in?</tt></font>
<br><font size=2><tt>Are there any good documentaion about the new input
device system ?</tt></font>
<br>
<br><font size=2><tt>Basically I am totally confused ;-), so any ideas
are appreciated.<br>
<br>
Cheers<br>
<br>
Harald<br>
</tt></font>
--=_alternative 002CC12AC1257185_=--
