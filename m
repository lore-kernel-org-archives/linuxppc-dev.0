Message-ID: <61891BA043DED21180920090273F173874D0EA@TNINT06>
From: Naushit Sakarvadia <nsakarvadia@telogy.com>
To: "'Grant Carter'" <gcarter@eng.uct.ac.za>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Serial ports
Date: Fri, 10 Dec 1999 14:09:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Does anyone have any ideas where I can go from here. I am not 
> 100% that the hardware is working so perhaps that could be the problem.

if you doubt your hardware then.. do this to test it.

first of all write a routine that countineously write "ox55" or "oxAA"
on the serial port. then check the pin no 2( i.e always transmit) and check
you should be gettinhg "squere wave" on that pin with respect to ground( i.e
pin 7)


-- Naushit 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
