Return-Path: <Sylvain.Cote@verint.com>
Received: from exprod7og107.obsmtp.com (exprod7og107.obsmtp.com [64.18.2.167])
	by bilbo.ozlabs.org (Postfix) with SMTP id 9389EB7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 01:28:18 +1000 (EST)
From: "Cote, Sylvain" <Sylvain.Cote@verint.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 22 Jun 2009 11:13:41 -0400
Subject: ppc405ex GPIO mapping
Message-ID: <579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1@ATLMBX.verint.corp.verintsystems.com>
Content-Type: multipart/alternative;
	boundary="_000_579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1ATLMBXverin_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1ATLMBXverin_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am using kernel 2.6.25.20 on my Kilauea eval board (ppc405ex).  I want to=
 access some GPIO's.  I have configured my u-boot to reflect what GPIO conf=
iguration I need.  I try to access my GPIO's in my driver.  When accessing =
GPIO's, I get this error in the kernel <<Unable to handle kernel paging req=
uest for data at address 0xef600800>>.   0xef600800 is the base address of =
GPIO in the ppc405ex.

It looks like GPIO's are not mapped in my kernel.  I have tried to add this=
 entry in my dts file (under POB0: opb ) but it does not work:

GPIO: gpio@ef600800
{
compatible =3D "ibm,gpio-405ex";
reg =3D <ef600800 00000020>;
};


Any clues on this issues?


Thanks

Sylvain C.

This electronic message may contain proprietary and confidential informat=
ion of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1ATLMBXverin_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:st1=3D"urn:schemas-microsoft-com:off=
ice:smarttags" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>I am using kernel 2.6.25.20 on my <st1:place w:st=
=3D"on">Kilauea</st1:place>
eval board (ppc405ex).&nbsp; I want to access some GPIO&#8217;s.&nbsp; I ha=
ve
configured my u-boot to reflect what GPIO configuration I need. &nbsp;I try=
 to
access my GPIO&#8217;s in my driver.&nbsp; When accessing GPIO&#8217;s, I g=
et
this error in the kernel &lt;&lt;Unable to handle kernel paging request for
data at address 0xef600800&gt;&gt;. &nbsp;&nbsp;0xef600800 is the base addr=
ess
of GPIO in the ppc405ex.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'>It looks like GPIO&#8217;s are not mapped in my
kernel. &nbsp;I have tried to add this entry in my dts file (under POB0: op=
b ) but
it does not work:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>GPIO: gpio@ef600800 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>{&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'>compatible =3D
&quot;ibm,gpio-405ex&quot;;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 face=3DArial=
><span
lang=3DFR style=3D'font-size:10.0pt;font-family:Arial'>reg =3D &lt;ef600800
00000020&gt;;&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'>Any clues on this issues?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size:1=
0.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>Thanks&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR style=3D'f=
ont-size:10.0pt;
font-family:Arial'>Sylvain C.<o:p></o:p></span></font></p>

</div>

</body>

</html>

<pre>This electronic message may contain proprietary and confidential inf=
ormation of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FEF815F1ATLMBXverin_--
