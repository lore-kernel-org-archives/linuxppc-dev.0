Return-Path: <pjmaiya@signal-networks.com>
Received: from smtp.net4india.com (smtp.net4india.com [202.71.129.73])
	by ozlabs.org (Postfix) with ESMTP id 9A8AEDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Dec 2006 21:39:30 +1100 (EST)
Received: from [61.95.204.104] (helo=signal-networks.com)
	by smtp.net4india.com with esmtp (Exim 4.54) id 1H0aOo-0000sZ-5B
	for linuxppc-embedded@ozlabs.org; Sat, 30 Dec 2006 14:51:06 +0530
Received: from pjmaiya ([192.168.1.70])
	by signal-networks.com (mail.signal-networks.com [192.168.1.1])
	(MDaemon Standard v9.0.1) with ESMTP id md50000054761.msg
	for <linuxppc-embedded@ozlabs.org>; Sat, 30 Dec 2006 14:53:02 +0530
Message-ID: <001301c72bf4$19b5d4f0$4601a8c0@signet>
From: "pjmaiya" <pjmaiya@signal-networks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: SPI and ttyS1 problem
Date: Sat, 30 Dec 2006 14:53:00 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C72C22.335D4810"
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

------=_NextPart_000_0010_01C72C22.335D4810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi
  I am working on powerpc(Mpc860T) with linux-2.4 kernnel,

As I am developping  application using spi and with irqs:=20
For each 10 millisec I am getting siu interrupt(timer),In the=20
interrupt handler I have to read my device (using spi communication)
I am able to write it (I am able drive my device)
  All other interrupts I am using are  cpm =
interrupts(smc2.timer2,spi),one=20
siu interrupt for the present ,

I am facing the following problems:
1.No more spi read takes place : case-if i tried to do continous serial =
print using ttyS1(SMC2)
2. if I limited number of times of print then SPI read will not have =
probelm
 =20
How can i solve this with prbklem

 thanks to all ...
  pjmaiya

=20

------=_NextPart_000_0010_01C72C22.335D4810
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial>hi<BR>&nbsp; I am working on powerpc(Mpc860T) =
with=20
linux-2.4 kernnel,</FONT></DIV><FONT face=3DArial>
<DIV><BR>As I am developping&nbsp; application using spi and with irqs: =
<BR>For=20
each 10 millisec I am getting siu interrupt(timer),In the <BR>interrupt =
handler=20
I have to read my device&nbsp;(using spi communication)<BR>I am able to =
write it=20
(I am able drive my device)<BR>&nbsp; All other interrupts I am using =
are&nbsp;=20
cpm interrupts(smc2.timer2,spi),one <BR>siu interrupt for the present =
,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am facing the following problems:<BR>1.No more spi read takes=20
place&nbsp;: case-if i tried to do continous serial print using=20
ttyS1(SMC2)<BR>2. if I limited number of times of print then SPI read =
will not=20
have probelm</DIV>
<DIV>&nbsp;&nbsp;<BR>How can i solve this with prbklem</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;thanks to all=20
...<BR>&nbsp;&nbsp;pjmaiya<BR><BR>&nbsp;<BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0010_01C72C22.335D4810--
