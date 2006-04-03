Return-Path: <TSchnuerer@men.de>
Received: from [172.16.102.117] (auth.men.de [195.127.220.114])
	by ozlabs.org (Postfix) with ESMTP id E6266679F0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Apr 2006 20:34:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65708.84652E7A"
Subject: MPC5200 FEC Ethernet only halfduplex ?
Date: Mon, 3 Apr 2006 12:22:31 +0200
Message-ID: <0ABEEA3685414344B4BE536AE3912E6EC0506F@men-exch1.intra.men.de>
From: =?iso-8859-1?Q?Thomas_Schn=FCrer?= <TSchnuerer@men.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65708.84652E7A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Im working with Linux on our MPC5200 Board, with the latest Rev. B3 =
Processor.
I was updating our Linux BSP from BestComm 2.1 to 2.2 some time ago and =
used your patches which increased usability of the FEC very much.
=20
There is a line in the driver code which I dont understand, it says:
+ fec_restart(dev, 0); /* always use half duplex mode only */
=20
Why can only half duplex be used ? I made a test with the iperf tool and =
saw that with the driver in its current state I get 90 Mbit/s in one =
direction and only 10 kBit/ other way. When changing the fec_restart =
call to (dev, 1) it turns to 90 Mbit and 250 kBit/s.
Then I changed for couriosity the BestComm task prioritisation and =
suddenly I get 90 Mbit in both directions.
So whats the reason for this setting above ?
=20
Thanks in advance!

------_=_NextPart_001_01C65708.84652E7A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Im working with Linux on our MPC5200 =
Board, with=20
the latest Rev. B3 Processor.<BR>I was updating our Linux BSP from =
BestComm 2.1=20
to 2.2 some time ago and used your patches which increased usabilit<SPAN =

class=3D277362110-03042006>y</SPAN> of the FEC very much.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>There is a line in the driver code =
which I dont=20
understand, it says:<BR>+ fec_restart(dev, 0); /* always use half duplex =
mode=20
only */</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Why can only half duplex be used ? I =
made a test=20
with the iperf tool and saw that with the driver in its current state I =
get 90=20
Mbit/s in one direction and only 10 kBit/ other way. When changing the=20
fec_restart call to (dev, 1) it turns to 90 Mbit and 250 kBit/s.<BR>Then =
I=20
changed for couriosity the BestComm task prioritisation and suddenly I =
get 90=20
Mbit in both directions.<BR>So whats the reason for this setting above=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in =
advance!</FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C65708.84652E7A--
