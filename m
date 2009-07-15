Return-Path: <Sylvain.Cote@verint.com>
Received: from exprod7og116.obsmtp.com (exprod7og116.obsmtp.com [64.18.2.219])
	by bilbo.ozlabs.org (Postfix) with SMTP id E48B7B708D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 22:22:37 +1000 (EST)
From: "Cote, Sylvain" <Sylvain.Cote@verint.com>
To: sudheer a <a.sudheer443@gmail.com>
Date: Wed, 15 Jul 2009 08:22:23 -0400
Subject: RE: ethernet driver - problem capturing own packet in promiscous mode
Message-ID: <579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202C@ATLMBX.verint.corp.verintsystems.com>
References: <4312c3250907150136y4c98c78ak1b4fe50534248442@mail.gmail.com>
In-Reply-To: <4312c3250907150136y4c98c78ak1b4fe50534248442@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202CATLMBXverin_"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202CATLMBXverin_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Hi all

> In ethernet driver  i need to enable promiscous mode and have to capture =
the packet that is sent by the same ethernet.

> The board is connected to a packet generator and could send/receive packe=
ts  whenever i need .

> In the board ethernet driver , I made sure that am sending only broadcast=
 packets and promisc mode is enabled but the packets are not captured. If i=
 am sending a packet to the board from packetgenerator it is receiving.

> Could any one please suggest me any clues.

> Having the promisc enabled:
> Packet sent by packetgenerator is received by board.
> Packet sent by board is received by packetgenerator, The same packet shou=
ld be captured by board as promiscuous is enabled. but not happening.


The Ethernet interface that sent the packet will never receive the packet i=
t sent even if you are in promiscuous mode.  To be able to do that you shou=
ld put your interface in loopback mode.
In promiscuous mode, you will be able to receive any packets sent by other =
interfaces (broadcast, multicast and also unicast that is not directed to y=
ou interface MAC address).  But not
from your interface.

Regards

Sylvain

This electronic message may contain proprietary and confidential informat=
ion of Verint Systems Inc., its affiliates and/or subsidiaries.
The information is intended to be for the use of the individual(s) or
entity(ies) named above.  If you are not the intended recipient (or autho=
rized to receive this e-mail for the intended recipient), you may not use=
, copy, disclose or distribute to anyone this message or any information =
contained in this message.  If you have received this electronic message =
in error, please notify us by replying to this e-mail.
=0D
--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202CATLMBXverin_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
lang=3DEN-US style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>Hi al=
l<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>In ethernet driver
&nbsp;i need to enable promiscous mode and have to capture the packet that =
is
sent by the same ethernet. <o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>The board is conne=
cted
to a packet generator and could send/receive packets &nbsp;whenever i need =
.<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>In the board ether=
net
driver , I made sure that am sending only broadcast packets and promisc mod=
e is
enabled but the packets are not captured. If i am sending a packet to
the&nbsp;board from&nbsp;packetgenerator it is receiving.<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>Could any one plea=
se
suggest me any clues.<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>Having the promisc
enabled:<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>Packet sent by
packetgenerator is received by board.<o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>&gt; </span></font>Packet sent by boa=
rd is
received by packetgenerator, The same packet should be captured by board as
promiscuous is enabled. but not happening.<font color=3Dnavy><span
style=3D'color:navy'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>The Ethernet interface that sent the =
packet
will never receive the packet it sent even if you are in promiscuous mode.&=
nbsp; To
be able to do that you should put your interface in loopback mode.&nbsp; <o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dnavy face=3D"Times New Roman"><=
span
style=3D'font-size:12.0pt;color:navy'>In promiscuous mode, you will be able=
 to
receive any packets sent by other interfaces (broadcast, multicast and also
unicast that is not directed to you interface MAC address). &nbsp;But not<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>from your interface.<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Sylvain<o:p></o:p></span></font></p>

</div>

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
--_000_579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202CATLMBXverin_--
