Return-Path: <Daniel.Wyss@securiton.ch>
Received: from mrp.swissptt.ch (outmail27.swisscom.com [138.190.3.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "outmail2.swisscom.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3853ADDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 01:00:44 +1100 (EST)
Received: from stnzolav1.securiton.int (stnzolex1.securiton.int [10.101.10.36])
	by mrp.swissptt.ch with ESMTP id l2GDdUTU013356
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 14:39:30 +0100 (MET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C767D0.84F43449"
Subject: RE: login on console=tty with serial input
Date: Fri, 16 Mar 2007 14:39:28 +0100
Message-ID: <381D3B2C62C8B94B95219E2DA47C8DCF08E3CA@stnzolex2.securiton.int>
In-Reply-To: <OF1C808DEE.C8EB82B2-ONC1257295.003752BA-C1257296.0038EEB2@rockwellcollins.com>
References: <OF1C808DEE.C8EB82B2-ONC1257295.003752BA-C1257296.0038EEB2@rockwellcollins.com>
From: <Daniel.Wyss@securiton.ch>
To: <hbruegge@rockwellcollins.com>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C767D0.84F43449
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Harald
=0D
Did you find a solution for your problem?=0D

=0D

I have almost a similar problem.=0D

On a MPC885 board I have one serial line, an Ethernet port and a QVGA=
 display with a /dev/fb.

As GUI library, I started to evaluate Nano-X, FLTK and wxWitgets. But there=
 is the problem that I don't have keyboard input whether form the serial=
 line nor form a remote shell (Ethernet).=0D

As far I understand the matter the problem is that the console that is=
 running on the frame buffer needs as input a keyboard device and not a=
 serial line. Unfortunately I found till now no solution to redirect the=
 serial line to a keyboard device.=0D

=0D

Regards
Daniel Wyss
----------------------------------------------
SECURITON AG Alarm- und Sicherheitssysteme

Daniel Wyss
Entwicklung Sicherheitssysteme
Alpenstrasse 20
CH - 3052 Zollikofen

Phone:  +41 31 910 11 22
Fax:    +41 31 910 13 03
Direct: +41 31 910 14 37 =0D
E-Mail: daniel.wyss@securiton.ch
http://www.securiton.ch <http://www.securiton.ch/>=0D
----------------------------------------------=0D

=0D


________________________________

	From: linuxppc-embedded-bounces+daniel.wyss=3Dsecuriton.ch@ozlabs.org=
 [mailto:linuxppc-embedded-bounces+daniel.wyss=3Dsecuriton.ch@ozlabs.org]=
 On Behalf Of hbruegge@rockwellcollins.com
	Sent: Tuesday, March 06, 2007 11:22 AM
	To: linuxppc-embedded@ozlabs.org
	Subject: login on console=3Dtty with serial input
=0D
=0D

	Hi everyone.=0D
=0D
=0D
	I just wondering, if anyone outthere can help me. I am currently kind of=
 lost.=0D
=0D
	I have an embedded powerpc based system running with kernel 2.6.20.  The=
 system has only two serial lines and no PS/2 or USB support. Therefore I=
 control the system via a serial console ( passing the commandline arg:=
 console=3DttyS0,57600) and a terminal.=0D
	A getty program is running on /dev/console, which gives me a login:=
 prompt, so I can login via the serial line ttyS0.=0D
	All is working pretty perfect.=0D
=0D
	So far so good. And now here comes my problem.=0D
	To add a better MMI in the future I want to use the graphic card as an=
 output.=0D
=0D
	I added a  graphic card to the system. The kernel configuration includes=
 framebuffer support for that particular graphic card.=0D
	After booting the kernel, I can see a /dev/fb0 device and testing with=
 'echo "hello" > /dev/fb0', the message "hello" is displayed on the screen.=
=0D
	Also if I add the commandline arg: console=3Dtty console=3DttyS0,57600 , I=
 get all kernel messages displayed, not only on the serial line, but also=
 on the screen via the framebuffer.=0D
=0D
	So basically, what I want is graphical output (dev/fb0) with serial input=
 (/dev/ttyS0). The user sees a login prompt on the screen and can enter=
 characters by a terminal program connected to the serial line.=0D
	Right to that point I always used the serial console for user interaction.=
 By adding only the commandline argument console=3Dtty, I get a nice login=
 prompt on the graphic screen. BUT I have no input via the serial line???=0D
=0D
	So, how do I connect the serial line /dev/ttySx  to the standard input=
 path of the virtual console.=0D
=0D
	Any hint is welcomed. Any manuals to read are also welcomed.=0D
=0D
	Thanx=0D
=0D
	Harald Br=FCggemann=0D
=0D
	--------------------------------------------------------
	Harald Br=FCggemann
	Rockwell Collins Deutschland GmbH
	Grenzh=F6ferWeg 36
	D-69046 Heidelberg
	Germany
=0D
	Phone:     +49 - 6221 - 512 484
	Fax:          +49 - 6221 - 512 301
=0D
	e-mail:   hbruegge@rockwellcollins.com



<html>
<body>
<font face =3D "arial" size =3D "1">
---------------------------------------------------------------------------=
------------------------------
This e-mail is confidential and may contain privileged information.
It is intended only for the addressees. If you have received this
e-mail in error, kindly notify us immediately by telephone or e-mail
and delete the message from your system.
---------------------------------------------------------------------------=
------------------------------
</font>
</body>
</html>
------_=_NextPart_001_01C767D0.84F43449
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=
=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D738091813-16032007><FONT face=
=3DArial=0D
color=3D#0000ff size=3D2>Hi Harald</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D738091813-16032007>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US">Did=0D
you find a solution for your problem? </SPAN><SPAN lang=3DEN-US=0D
style=3D"mso-ansi-language: EN-US"><?xml:namespace prefix =3D o ns =3D=0D
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"mso-ansi-language: EN-US"><FONT size=3D3><FONT color=
=3D#000000><FONT=0D
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US">I=0D
have almost a similar problem. </SPAN><SPAN lang=3DEN-US=0D
style=3D"mso-ansi-language: EN-US"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US">On=0D
a MPC885 board I have one serial line, an Ethernet port and a QVGA display=
 with=0D
a /dev/fb.</SPAN><SPAN lang=3DEN-US=0D
style=3D"mso-ansi-language: EN-US"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US">As=0D
GUI library, I started to evaluate Nano-X, FLTK and wxWitgets. But there is=
 the=0D
problem that I don't have keyboard input whether form the serial line nor=
 form a=0D
remote shell (Ethernet). </SPAN><SPAN lang=3DEN-US=0D
style=3D"mso-ansi-language: EN-US"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US">As=0D
far I understand the matter the problem is that the console that is running=
 on=0D
the frame buffer needs as input a keyboard device and not a serial line.=0D
Unfortunately I found till now no solution to redirect the serial line to a=
=0D
keyboard device. </SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-US=0D
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: Arial;=
 mso-ansi-language: EN-US"></SPAN><SPAN=0D
lang=3DEN-US=0D
style=3D"mso-ansi-language:=
 EN-US"><o:p></o:p></SPAN>&nbsp;</P></SPAN></FONT><FONT=0D
face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D738091813-16032007></SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D738091813-16032007>Regards</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D738091813-16032007>Daniel=0D
Wyss</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D738091813-16032007><!-- Converted from text/plain format -->
<P><FONT size=
=3D2>----------------------------------------------<BR>SECURITON AG=0D
Alarm- und Sicherheitssysteme<BR><BR>Daniel Wyss<BR>Entwicklung=0D
Sicherheitssysteme<BR>Alpenstrasse 20<BR>CH - 3052=0D
Zollikofen<BR><BR>Phone:&nbsp; +41 31 910 11 22<BR>Fax:&nbsp;&nbsp;&nbsp;=
 +41 31=0D
910 13 03<BR>Direct: +41 31 910 14 37&nbsp;&nbsp;<BR>E-Mail:=0D
daniel.wyss@securiton.ch<BR><A=0D
href=
=3D"http://www.securiton.ch/">http://www.securiton.ch</A><BR>--------------=
--------------------------------</FONT>=0D
</P></SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><BR></DIV>
<BLOCKQUOTE=0D
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px=
 solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Dde dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=0D
  linuxppc-embedded-bounces+daniel.wyss=3Dsecuriton.ch@ozlabs.org=0D
  [mailto:linuxppc-embedded-bounces+daniel.wyss=3Dsecuriton.ch@ozlabs.org]=
 <B>On=0D
  Behalf Of </B>hbruegge@rockwellcollins.com<BR><B>Sent:</B> Tuesday, March=
 06,=0D
  2007 11:22 AM<BR><B>To:</B>=
 linuxppc-embedded@ozlabs.org<BR><B>Subject:</B>=0D
  login on console=3Dtty with serial input<BR></FONT><BR></DIV>
  <DIV></DIV><BR><FONT face=3Dsans-serif size=3D2>Hi everyone.</FONT>=0D
  <BR><BR><BR><FONT face=3Dsans-serif size=3D2>I just wondering, if anyone=
 outthere=0D
  can help me. I am currently kind of lost.</FONT> <BR><BR><FONT face=
=3Dsans-serif=0D
  size=3D2>I have an embedded powerpc based system running with kernel=
 2.6.20.=0D
  &nbsp;The system has only two serial lines and no PS/2 or USB support.=0D
  Therefore I control the system via a serial console ( passing the=
 commandline=0D
  arg: console=3DttyS0,57600) and a terminal.</FONT> <BR><FONT face=
=3Dsans-serif=0D
  size=3D2>A getty program is running on /dev/console, which gives me a=
 login:=0D
  prompt, so I can login via the serial line ttyS0.</FONT> <BR><FONT=0D
  face=3Dsans-serif size=3D2>All is working pretty perfect.</FONT>=
 <BR><BR><FONT=0D
  face=3Dsans-serif size=3D2>So far so good. And now here comes my problem.=
=0D
  </FONT><BR><FONT face=3Dsans-serif size=3D2>To add a better MMI in the=
 future I=0D
  want to use the graphic card as an output.</FONT> <BR><BR><FONT=0D
  face=3Dsans-serif size=3D2>I added a &nbsp;graphic card to the system.=
 The kernel=0D
  configuration includes framebuffer support for that particular graphic=
 card.=0D
  </FONT><BR><FONT face=3Dsans-serif size=3D2>After booting the kernel, I=
 can see a=0D
  /dev/fb0 device and testing with 'echo "hello" &gt; /dev/fb0', the=
 message=0D
  "hello" is displayed on the screen. </FONT><BR><FONT face=3Dsans-serif=0D
  size=3D2>Also if I add the commandline arg: console=3Dtty console=
=3DttyS0,57600 , I=0D
  get all kernel messages displayed, not only on the serial line, but also=
 on=0D
  the screen via the framebuffer.</FONT> <BR><BR><FONT face=3Dsans-serif=
 size=3D2>So=0D
  basically, what I want is graphical output (dev/fb0) with serial input=0D
  (/dev/ttyS0). The user sees a login prompt on the screen and can enter=0D
  characters by a terminal program connected to the serial line.</FONT>=0D
  <BR><FONT face=3Dsans-serif size=3D2>Right to that point I always used=
 the serial=0D
  console for user interaction. By adding only the commandline argument=0D
  console=3Dtty, I get a nice login prompt on the graphic screen. BUT I=
 have no=0D
  input via the serial line???</FONT> <BR><BR><FONT face=3Dsans-serif size=
=3D2>So,=0D
  how do I connect the serial line /dev/ttySx &nbsp;to the standard input=
 path=0D
  of the virtual console.</FONT> <BR><BR><FONT face=3Dsans-serif size=
=3D2>Any hint=0D
  is welcomed. Any manuals to read are also welcomed. </FONT><BR><BR><FONT=
=0D
  face=3Dsans-serif size=3D2>Thanx</FONT> <BR><BR><FONT face=3Dsans-serif=0D
  size=3D2>Harald Br=FCggemann</FONT> <BR><FONT face=3Dsans-serif=0D
  size=
=3D2><BR>--------------------------------------------------------<BR>Harald=
=0D
  Br=FCggemann<BR>Rockwell Collins Deutschland GmbH<BR>Grenzh=F6ferWeg=
 36<BR>D-69046=0D
  Heidelberg<BR>Germany<BR><BR>Phone:&nbsp;&nbsp;&nbsp;&nbsp; +49 - 6221 -=
 512=0D
  484<BR>Fax:&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;+49 - 6221 -=
 512=0D
 =
 301<BR><BR>e-mail:&nbsp;&nbsp;&nbsp;hbruegge@rockwellcollins.com</FONT></B=
LOCKQUOTE></BODY></HTML>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><html><br>
<body><br>
<font face =3D "arial" size =3D "1"><br>
---------------------------------------------------------------------------=
------------------------------<br>
This e-mail is confidential and may contain privileged information.<br>
It is intended only for the addressees. If you have received this<br>
e-mail in error, kindly notify us immediately by telephone or e-mail<br>
and delete the message from your system.<br>
---------------------------------------------------------------------------=
------------------------------<br>
</font><br>
</body><br>
</html><br>
</font></td></tr></table>
------_=_NextPart_001_01C767D0.84F43449--
