Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	by ozlabs.org (Postfix) with ESMTP id D889267BA7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 19:17:24 +1000 (EST)
Received: from esealmw129.eemea.ericsson.se (unknown [153.88.254.120])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id 0972AD13
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 08:48:45 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CD92.AA7EBCC9"
Subject: Backtrace
Date: Fri, 1 Sep 2006 08:48:43 +0200
Message-ID: <24521B9781EAC745A4BE65966F69C9BE02BACDA8@esealmw115.eemea.ericsson.se>
From: "Matias Sundman \(AS/EAB\)" <matias.sundman@ericsson.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6CD92.AA7EBCC9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Comrades,
I would like to do a backtrace in kernel space similar to an oops but =
then continue the code flow as before i.e. without a crash.
If someone has done anything similar, help and/or tips would be much =
appreciated!

Cheers //

Matias Sundman
Senior Sw Designer
Ericssonl
IS Ethernet Switch, DIPN
Ericsson AB
Box 1505			Office:	+46  8 719 86 83
SE-125 25 =C4LVSJ=D6		ECN:	850 98683
SWEDEN			Mobile:	+46 70 267 2405
Visiting address:		E-mail:	Matias.Sundman@ericsson.com
Armborstv=E4gen 14		Web:	http://www.ericsson.com
=C4lvsj=F6, STOCKHOLM



------_=_NextPart_001_01C6CD92.AA7EBCC9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>Backtrace</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Comrades,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I would like to do a backtrace in =
kernel space similar to an oops but then continue the code flow as =
before i.e. without a crash.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If someone has done anything similar, =
help and/or tips would be much appreciated!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Cheers //</FONT>
</P>

<P><B><I><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Matias =
Sundman<BR>
</FONT></SPAN></I></B><I><SPAN LANG=3D"en-us"></SPAN></I><SPAN =
LANG=3D"en-us"><FONT SIZE=3D1 FACE=3D"Times New Roman">Senior Sw =
Designer</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Ericsson">Ericsson</FONT><B></B><B><FONT COLOR=3D"#0000FF" =
SIZE=3D1 FACE=3D"Ericsson">l</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D1 FACE=3D"Arial">IS Ethernet =
Switch, DIPN</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D1 FACE=3D"Tahoma">Ericsson =
AB</FONT></B></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D1 FACE=3D"Tahoma">Box =
1505&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Office: +46&nbsp; 8 719 86 =
83</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D1 FACE=3D"Tahoma">SE-125 25 =
=C4LVSJ=D6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ECN:&nbsp;&nbsp;&nbsp; 850 =
98683</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D1 FACE=3D"Tahoma">SWEDEN&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mobile: +46 70 267 =
2405</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D1 FACE=3D"Tahoma">Visiting =
address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"sv"> <FONT SIZE=3D1 FACE=3D"Tahoma">E-mail:<U> =
</U></FONT><U><FONT COLOR=3D"#0000FF" SIZE=3D1 =
FACE=3D"Tahoma">Matias.Sundman@ericsson.com</FONT></U></SPAN><SPAN =
LANG=3D"en-us"></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D1 FACE=3D"Tahoma">Armborstv=E4gen =
14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Web:&nbsp;&nbsp;&nbsp; =
</FONT></SPAN><A HREF=3D"http://www.ericsson.com"><SPAN =
LANG=3D"sv"></SPAN><SPAN LANG=3D"sv"><U><FONT COLOR=3D"#0000FF" SIZE=3D1 =
FACE=3D"Tahoma">http://www.ericsson.com</FONT></U></SPAN><SPAN =
LANG=3D"sv"></SPAN></A><SPAN LANG=3D"sv"></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D1 FACE=3D"Tahoma">=C4lvsj=F6, =
STOCKHOLM</FONT></SPAN>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C6CD92.AA7EBCC9--
