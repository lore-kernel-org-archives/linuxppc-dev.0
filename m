Return-Path: <trueskew@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 9DD6E67B59
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Jun 2006 14:47:12 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so1002358pye
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 21:47:11 -0700 (PDT)
From: "Trueskew" <trueskew@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Using bestcomm in an external module (MPC5200B to be exact)
Date: Fri, 16 Jun 2006 21:47:09 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00BF_01C6918E.6BE10390"
Message-ID: <4493894e.6d57ffd8.019a.ffff95b9@mx.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00BF_01C6918E.6BE10390
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm writing a driver for a TI codec attached to the MPC5200B PSC3 codec
lines on a Lite5200b.  It's an external module, and I'd like to use Bestcomm
with it.  I've already tried a bunch of horrible things to get it to work.
I could say it's close, but by close I mean the FEC still runs, my stuff
doesn't.  
 
1. Can the Bestcomm I/F be used by an external module, or is the module
required to be built in if built-in drivers use Bestcomm?  TasksInitAPI (no
so bad) and TasksLoadImage (yeah, bad) aren't really supposed to be called
more than once from what I've read, and the kernel loads them for ethernet
and ATA (no disk in my system if that matters).  
 
2. If it can be used by an external module, how would I do it?  I've tried
compiling the source into my module and replicating the initialization the
kernel does in addition to my own stuff.  It's not too bad, though I don't
get any interrupts yet.
 
The LTIB from Freescale includes AIC23 and AC97 drivers that use Bestcomm.
I built my kernel with them set as modules, and they had the same unresolved
problems that my driver has on insmod, so I'm pessimistic.  If someone could
put me out of my misery one way or another, I'd appreciate it.
 
Thanks.
Sal
 

------=_NextPart_000_00BF_01C6918E.6BE10390
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial size=3D2>I'm =
writing a driver=20
for a TI codec attached to the MPC5200B PSC3 codec lines on a =
Lite5200b.&nbsp;=20
It's an external module, and I'd like to use Bestcomm with it.&nbsp; =
I've=20
already tried a bunch of horrible things to get it to work.&nbsp; I =
could say=20
it's close, but by close I mean the FEC still runs, my stuff =
doesn't.&nbsp;=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial size=3D2><SPAN=20
class=3D012192304-17062006></SPAN></FONT></SPAN><SPAN=20
class=3D012192304-17062006><FONT face=3DArial size=3D2><SPAN=20
class=3D012192304-17062006></SPAN>&nbsp;</DIV></FONT></SPAN>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial size=3D2>1. Can =
the Bestcomm=20
I/F be used by an external module, or&nbsp;is the module required to be =
built in=20
if built-in drivers use Bestcomm?&nbsp; TasksInitAPI (no so bad) and=20
TasksLoadImage (yeah, bad) aren't really supposed to be called more than =
once=20
from what I've read, and the kernel loads them for ethernet and ATA (no =
disk in=20
my system if that matters).&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial size=3D2>2. If =
it can be used=20
by an external module, how would I do it?&nbsp; I've tried compiling the =
source=20
into my module and replicating the initialization the kernel does in =
addition to=20
my own stuff.&nbsp; It's not too bad, though I don't get any interrupts=20
yet.</FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial size=3D2><SPAN=20
class=3D012192304-17062006><FONT face=3DArial size=3D2><SPAN=20
class=3D012192304-17062006><FONT face=3DArial size=3D2>The LTIB from =
Freescale=20
includes AIC23 and AC97 drivers that use Bestcomm.&nbsp;=20
</FONT></SPAN></FONT></SPAN>I built my kernel with them set as modules, =
and they=20
had the same unresolved problems that my driver has on insmod, so I'm=20
pessimistic.&nbsp; If someone could put me out of my misery one way or =
another,=20
I'd appreciate it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2>Thanks.</FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2>Sal</FONT></SPAN></DIV>
<DIV><SPAN class=3D012192304-17062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00BF_01C6918E.6BE10390--
