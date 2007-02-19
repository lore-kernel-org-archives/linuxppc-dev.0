Return-Path: <ami@waves.com>
Received: from dcmail1.waves.com (dcmail1.waves.com [12.34.136.6])
	by ozlabs.org (Postfix) with SMTP id 2FDC4DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 03:48:10 +1100 (EST)
From: "Ami Levi Waves" <ami@waves.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: gdb - dgbserver problem
Date: Mon, 19 Feb 2007 17:40:31 +0100
Message-ID: <000801c75444$c5e24c40$0600000a@waves.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C7544D.27A6B440"
Reply-To: ami@waves.com
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

------=_NextPart_000_0009_01C7544D.27A6B440
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

Hi there,

I'm having a problem when using gdb to debug an application via the
gdbserver. It seems the gdbserver crashes when I issue "continue" =
command
(the target just hangs, no response, no messages on the Linux console).

This is what I'm getting on the gdb side (I'm using verbose and debug
modes):

(gdb) continue

Continuing.

Sending packet: $Z0,100004dc,4#02...Ack

Packet received:

Packet Z0 (software-breakpoint) is NOT supported

Sending packet: $m100004dc,4#b9...Ack

Packet received: 3d201000

Sending packet: $X100004dc,0:#da...Ack

Packet received:

binary downloading NOT suppported by target

Sending packet: $M100004dc,4:7d821008#a1...Ack

Timed out.

Timed out.

Timed out.

Ignoring packet error, continuing...

Sending packet: $m3000c380,4#8e...Sending packet: =
$m3000c380,4#8e...Sending
packet: $m3000c380,4#8e...Sending packet: $m3000c380,4#8e...Timed out.

Timed out.

Timed out.

Ignoring packet error, continuing...

Reply contains invalid hex digit 116

=20

Here are a few words about my setup:

I'm using an Arabella 2.6.12 custom kernel that contains USB support.
Everything is working fine (Except for this problem).

I'm using the new DENX 4.1 toolchain to compile both my kernel &
application. I'm using Fedora desktop to run the gdb and the gdbserver =
is on
my custom MPC880 board.=20

I'm using IP to connect the gdb to gdbserver. I'm following the exact
guidelines described on DENX web site.=20

In order to simplify the problem I'm using a simple "hello world" =
program.=20

Any ideas?

Thanks.

Ami Levi


------=_NextPart_000_0009_01C7544D.27A6B440
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Hi there,</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m having a problem =
when using
gdb to debug an application via the gdbserver. It seems the gdbserver =
crashes
when I issue &#8220;continue&#8221; command (the target just hangs, no =
response,
no messages on the Linux console).</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>This is what I&#8217;m =
getting on
the gdb side (I&#8217;m using verbose and debug =
modes):</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>(gdb) continue</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Continuing.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sending packet: $Z0,100004dc,4#02...Ack</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Packet received:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Packet Z0 (software-breakpoint) is NOT =
supported</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sending packet: $m100004dc,4#b9...Ack</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Packet received: 3d201000</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sending packet: $X100004dc,0:#da...Ack</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Packet received:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>binary downloading NOT suppported by target</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sending packet: $M100004dc,4:7d821008#a1...Ack</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Timed out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Timed out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Timed out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Ignoring packet error, continuing...</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Sending packet: $m3000c380,4#8e...Sending packet: =
$m3000c380,4#8e...Sending
packet: $m3000c380,4#8e...Sending packet: $m3000c380,4#8e...Timed =
out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Timed out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Timed out.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Ignoring packet error, continuing...</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Reply contains invalid hex digit 116</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Here are a few words about =
my setup:</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m using an Arabella =
2.6.12
custom kernel that contains USB support. Everything is working fine =
(Except for
this problem).</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m using the new =
DENX 4.1 toolchain
to compile both my kernel &amp; application. I&#8217;m using Fedora =
desktop to
run the gdb and the gdbserver is on my custom MPC880 board. =
</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m using IP to =
connect the
gdb to gdbserver. I&#8217;m following the exact guidelines described on =
DENX
web site. </span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>In order to simplify the =
problem I&#8217;m
using a simple &#8220;hello world&#8221; program. </span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Any =
ideas?</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Thanks.</span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Ami =
Levi</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0009_01C7544D.27A6B440--
