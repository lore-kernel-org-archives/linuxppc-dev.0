Return-Path: <Daniele.Bosi@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 093C2B7D1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 May 2010 18:56:13 +1000 (EST)
Received: from mail.mta.it (mail.mta.it [91.143.207.180])
	by rly01a.srv.mailcontrol.com (MailControl) with ESMTP id
	o4R8OWkP018419
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 May 2010 09:24:45 +0100
From: Bosi Daniele <Daniele.Bosi@mta.it>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 27 May 2010 10:24:24 +0200
Subject: halt the system without any broadcast message on the console
Message-ID: <531B6536C9F737458807DF75064873C8BE62B40C48@mta-digimail.MTA.INT>
Content-Type: multipart/alternative;
	boundary="_000_531B6536C9F737458807DF75064873C8BE62B40C48mtadigimailMT_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_531B6536C9F737458807DF75064873C8BE62B40C48mtadigimailMT_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
on the embedded system I'm working (mpc5121e, linux kernel 2.6.24.6) when I=
 type the command "halt" on the console I see a broadcast message sent to a=
ll the users like this:

" Broadcast message from root (console) (Thu May 27 09:04:41 2010):

The system is going down for system halt NOW!"

I'd like to avoid this message on the console I'm using because at producti=
on time this has to be a simple serial port for external peripheral connect=
ion. (to do this on the command line we'll leave empty the "console" field)=
.

The only way I found to avoid the broadcast message is the command "telinit=
 0" . In this way no one calls the "shutdown" command that is the one which=
 send the broadcast message.
I did also some tests with the shutdown parameters but none of them erase t=
he broadcast message.

So my questions are:
Does the command  "telinit 0" is safe in order to halt the machine?
Does the command  "telinit 6" is safe in order to reboot the machine?
Are there others commands to do the same work without the broadcast message=
?


Thanks
Daniele Bosi

--_000_531B6536C9F737458807DF75064873C8BE62B40C48mtadigimailMT_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
strong
	{font-family:"Times New Roman";}
span.StileMessaggioDiPostaElettronica17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DIT link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Hi all,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>on the embedded system I&#8217;m working (mpc5121=
e, linux
kernel 2.6.24.6) when I type the command &#8220;halt&#8221; on the console =
I
see a broadcast message sent to all the users like this:<br>
<br>
&#8221;</span></font><span lang=3DEN-GB> </span><font size=3D2 face=3DArial=
><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>Broadcast message=
 from
root (console) (Thu May 27 </span></font><font size=3D2 face=3DArial><span
 lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>09:04:41</span><=
/font><font
size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fam=
ily:Arial'>
2010):</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>The system is going down for system halt NOW!&#82=
21;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;d like to avoid this message on the conso=
le I&#8217;m
using because at production time this has to be a simple serial port for
external peripheral connection. (to do this on the command line we&#8217;ll
leave empty the &#8220;console&#8221; field).<br>
<br>
The only way I found to avoid the broadcast message is the command &#8220;t=
elinit
0&#8221; . In this way no one calls the &#8220;shutdown&#8221; command that=
 is the
one which send the broadcast message.<br>
I did also some tests with the shutdown parameters but none of them erase t=
he
broadcast message.<br>
<br>
So my questions are:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Does the command &nbsp;&#8220;telinit 0&#8221; is
safe in order to halt the machine?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Does the command &nbsp;&#8220;telinit 6&#8221; is
safe in order to reboot the machine?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Are there others commands to do the same work wit=
hout
the broadcast message?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Thanks</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span lang=3DE=
N-GB
style=3D'font-size:12.0pt'>Daniele Bosi</span></font></p>

</div>

</body>

</html>

--_000_531B6536C9F737458807DF75064873C8BE62B40C48mtadigimailMT_--
