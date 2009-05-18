Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange.deka.local (mail.dekaresearch.com [208.65.175.196])
	by ozlabs.org (Postfix) with ESMTP id 3922DDE08A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:45:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9D7DF.2BFC71C8"
Subject: mpc5200 fec error
Date: Mon, 18 May 2009 13:36:27 -0400
Message-ID: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
From: "Eric Millbrandt" <emillbrandt@dekaresearch.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9D7DF.2BFC71C8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

=20

I am testing a 2.6.29.3 (with preempt_rt patches) kernel on a phytec
pcm030 and am getting a kernel hang when testing the fec Ethernet
controller.  The error only occurs when running the preempt-patched
kernel, an unmodified kernel works fine.  Is anyone out there using
preempt_rt on an MPC5200 successfully?

=20

Eric

=20

root@rudolph-ui:/root> iperf -c linux-5200bdevl01 -P 2 -i 1 -p 5001 -f k
-t 600

------------------------------------------------------------

Client connecting to linux-5200bdevl01, TCP port 5001

TCP window size: 36.2 KByte (default)

------------------------------------------------------------

[  4] local 10.1.4.88 port 37872 connected with 10.1.5.234 port 5001

[  3] local 10.1.4.88 port 37871 connected with 10.1.5.234 port 5001

[ ID] Interval       Transfer     Bandwidth

[  3]  0.0- 1.0 sec  3824 KBytes  31326 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  4]  0.0- 1.0 sec  3656 KBytes  29950 Kbits/sec

[SUM]  0.0- 1.0 sec  7480 KBytes  61276 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  4]  1.0- 2.0 sec  3760 KBytes  30802 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  3]  1.0- 2.0 sec  3752 KBytes  30736 Kbits/sec

[SUM]  1.0- 2.0 sec  7512 KBytes  61538 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  4]  2.0- 3.0 sec  3728 KBytes  30540 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  3]  2.0- 3.0 sec  3816 KBytes  31261 Kbits/sec

[SUM]  2.0- 3.0 sec  7544 KBytes  61800 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  3]  3.0- 4.0 sec  3712 KBytes  30409 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  4]  3.0- 4.0 sec  3824 KBytes  31326 Kbits/sec

[SUM]  3.0- 4.0 sec  7536 KBytes  61735 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  3]  4.0- 5.0 sec  3968 KBytes  32506 Kbits/sec

[ ID] Interval       Transfer     Bandwidth

[  4]  4.0- 5.0 sec  3624 KBytes  29688 Kbits/sec

[SUM]  4.0- 5.0 sec  7592 KBytes  62194 Kbits/sec

[ 5761.999175] net eth0: transmit queue overrun

[ 5762.003591] net eth0: transmit queue overrun

[ 5762.007948] net eth0: transmit queue overrun

[ 5762.012302] net eth0: transmit queue overrun

[ 5762.016658] net eth0: transmit queue overrun

[ 5762.021013] net eth0: transmit queue overrun

[ 5762.025381] net eth0: transmit queue overrun

[ 5762.029735] net eth0: transmit queue overrun

[ 5762.034090] net eth0: transmit queue overrun

[ 5762.038445] net eth0: transmit queue overrun

[ 5767.000928] net eth0: transmit queue overrun

[ 5767.005278] net eth0: transmit queue overrun

[ 5767.009634] net eth0: transmit queue overrun

[ 5767.013990] net eth0: transmit queue overrun

[ 5767.018345] net eth0: transmit queue overrun

[ 5767.022701] net eth0: transmit queue overrun

...



_________________________________________________________________________=
________________

This e-mail and the information, including any attachments, it contains =
are intended to be a confidential communication only to the person or =
entity to whom it is addressed and may contain information that is =
privileged. If the reader of this message is not the intended recipient, =
you are hereby notified that any dissemination, distribution or copying =
of this communication is strictly prohibited. If you have received this =
communication in error, please immediately notify the sender and destroy =
the original message.

Thank you.

Please consider the environment before printing this email.

------_=_NextPart_001_01C9D7DF.2BFC71C8
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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

<body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><!--ppd1000034--><!--ppd1000033-->

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am testing a 2.6.29.3 (with preempt_rt patches) =
kernel on
a phytec pcm030 and am getting a kernel hang when testing the fec =
Ethernet controller.&nbsp;
The error only occurs when running the preempt-patched kernel, an =
unmodified
kernel works fine.&nbsp; Is anyone out there using preempt_rt on an =
MPC5200
successfully?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Eric<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>root@rudolph-ui:/root&gt; iperf -c linux-5200bdevl01 =
-P 2 -i
1 -p 5001 -f k -t 600<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------------------------------------------------------=
------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Client connecting to linux-5200bdevl01, TCP port =
5001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP window size: 36.2 KByte =
(default)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------------------------------------------------------=
------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4] local 10.1.4.88 port 37872 connected with
10.1.5.234 port 5001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3] local 10.1.4.88 port 37871 connected with
10.1.5.234 port 5001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3]&nbsp; 0.0- 1.0 sec&nbsp; 3824 KBytes&nbsp; =
31326
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4]&nbsp; 0.0- 1.0 sec&nbsp; 3656 KBytes&nbsp; =
29950
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[SUM]&nbsp; 0.0- 1.0 sec&nbsp; 7480 KBytes&nbsp; =
61276
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4]&nbsp; 1.0- 2.0 sec&nbsp; 3760 KBytes&nbsp; =
30802
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3]&nbsp; 1.0- 2.0 sec&nbsp; 3752 KBytes&nbsp; =
30736
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[SUM]&nbsp; 1.0- 2.0 sec&nbsp; 7512 KBytes&nbsp; =
61538
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4]&nbsp; 2.0- 3.0 sec&nbsp; 3728 KBytes&nbsp; =
30540
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;Transfer&nbsp;&nbsp;&nbsp;&nbsp;
Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3]&nbsp; 2.0- 3.0 sec&nbsp; 3816 KBytes&nbsp; =
31261
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[SUM]&nbsp; 2.0- 3.0 sec&nbsp; 7544 KBytes&nbsp; =
61800
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3]&nbsp; 3.0- 4.0 sec&nbsp; 3712 KBytes&nbsp; =
30409
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4]&nbsp; 3.0- 4.0 sec&nbsp; 3824 KBytes&nbsp; =
31326
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[SUM]&nbsp; 3.0- 4.0 sec&nbsp; 7536 KBytes&nbsp; =
61735
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Transfer&nbsp;&nbsp;&nbsp;&nbsp; Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 3]&nbsp; 4.0- 5.0 sec&nbsp; 3968 KBytes&nbsp; =
32506
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ ID] Interval&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;Transfer&nbsp;&nbsp;&nbsp;&nbsp;
Bandwidth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 4]&nbsp; 4.0- 5.0 sec&nbsp; 3624 KBytes&nbsp; =
29688
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[SUM]&nbsp; 4.0- 5.0 sec&nbsp; 7592 KBytes&nbsp; =
62194
Kbits/sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5761.999175] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.003591] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.007948] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.012302] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.016658] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.021013] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.025381] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.029735] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.034090] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5762.038445] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.000928] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.005278] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.009634] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.013990] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.018345] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[ 5767.022701] net eth0: transmit queue =
overrun<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&#8230;.<o:p></o:p></span></font></p>

</div>

<BR><BR><P><FONT color=3Dgray =
size=3D2>________________________________________________________________=
_____________</FONT></P><P><FONT color=3Dgray size=3D2>This e-mail and =
the information, including any attachments, it contains are intended to =
be a confidential communication only to the person or entity to whom it =
is addressed and may contain information that is privileged. If the =
reader of this message is not the intended recipient, you are hereby =
notified that any dissemination, distribution or copying of this =
communication is strictly prohibited. If you have received this =
communication in error, please immediately notify the sender and destroy =
the original message.</FONT></P><P><FONT color=3Dgray size=3D2>Thank =
you.</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</P><BR><BR><P=
><FONT color=3Dgreen size=3D2>Please consider the environment before =
printing this email.</FONT></P></body>

</html>

------_=_NextPart_001_01C9D7DF.2BFC71C8--
