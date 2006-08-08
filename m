Return-Path: <keith.redfern@uk.flextronics.com>
Received: from ducmta01.flextronics.com (ducmta01.flextronics.com
	[217.79.214.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ducmta01.flextronics.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 5AF1A679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 23:00:12 +1000 (EST)
Received: from euduc502.europe.ad.flextronics.com
	(euduc502.europe.ad.flextronics.com [10.219.244.17])
	by ducmta01.flextronics.com (Symantec Mail Security) with ESMTP id
	B816660E for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 14:34:20 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BAE6.F8508357"
Subject: 852T: Problem getting traffic out FEC interface using vlan
Date: Tue, 8 Aug 2006 14:34:19 +0200
Message-ID: <367F3B3911959C4DA9991C00166F620C1BC52B@EUDUCEX2.europe.ad.flextronics.com>
From: "Keith Redfern" <keith.redfern@uk.flextronics.com>
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

------_=_NextPart_001_01C6BAE6.F8508357
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The system that I am using is as follows.....=0D=0A
=0D=0A
Embedded Linux on a Motorola 852T processor with FEC support. Embedded=0D=
=0A
Planet BSP=0D=0A
=0D=0A
Software that runs on the embedded processor to send UDP packets, via=0D=0A
the FEC port (eth1), to a PC. =0D=0A
=0D=0A
This PC is directly linked to the FEC port with a cable and is running=0D=
=0A
etherpeek.=0D=0A
=0D=0A
Software that runs on the embedded processor to listen to all received=0D=
=0A
traffic at the FEC (uses RAW packet socket).=0D=0A
=0D=0A
802.1q Support has been enabled in the kernel. 802.1Q VLAN Support v1.8=0D=
=0A
Ben Greear <greearb@candelatech.com>=0D=0A
=0D=0A
 =0D=0A
=0D=0A
The vlan configuration that I am applying is ......=0D=0A
=0D=0A
> ifconfig eth1 down=0D=0A
=0D=0A
> ifconfig eth1 0.0.0.0 up=0D=0A
=0D=0A
> vconfig add eth1 2=0D=0A
=0D=0A
> ifconfig eth1.2 192.168.2.2 up=0D=0A
=0D=0A
 =0D=0A
=0D=0A
After this is done ifconfig returns the following .....=0D=0A
=0D=0A
# ifconfig=0D=0A
=0D=0A
 =0D=0A
=0D=0A
eth0      Link encap:Ethernet  HWaddr 00:10:EC:00:52:FC=0D=0A
=0D=0A
          inet addr:10.226.210.86  Bcast:10.255.255.255  Mask:255.0.0.0=0D=
=0A
=0D=0A
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=0D=0A
=0D=0A
          RX packets:210599 errors:0 dropped:0 overruns:0 frame:0=0D=0A
=0D=0A
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0=0D=0A
=0D=0A
          collisions:0 txqueuelen:100=0D=0A
=0D=0A
          RX bytes:20804624 (19.8 MiB)  TX bytes:0 (0.0 B)=0D=0A
=0D=0A
          Base address:0x3e00=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
eth1      Link encap:Ethernet  HWaddr 00:10:EC:80:52:FC=0D=0A
=0D=0A
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=0D=0A
=0D=0A
          RX packets:64 errors:0 dropped:0 overruns:0 frame:0=0D=0A
=0D=0A
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0=0D=0A
=0D=0A
          collisions:0 txqueuelen:100=0D=0A
=0D=0A
          RX bytes:9055 (8.8 KiB)  TX bytes:365 (365.0 B)=0D=0A
=0D=0A
          Base address:0xe00=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
eth1.2    Link encap:Ethernet  HWaddr 00:10:EC:80:52:FC=0D=0A
=0D=0A
          inet addr:192.168.2.2  Bcast:192.168.2.255  Mask:255.255.255.0=0D=
=0A
=0D=0A
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=0D=0A
=0D=0A
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0=0D=0A
=0D=0A
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0=0D=0A
=0D=0A
          collisions:0 txqueuelen:0=0D=0A
=0D=0A
          RX bytes:0 (0.0 B)  TX bytes:276 (276.0 B)=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
lo        Link encap:Local Loopback=0D=0A
=0D=0A
          inet addr:127.0.0.1  Mask:255.0.0.0=0D=0A
=0D=0A
          UP LOOPBACK RUNNING  MTU:16436  Metric:1=0D=0A
=0D=0A
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0=0D=0A
=0D=0A
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0=0D=0A
=0D=0A
          collisions:0 txqueuelen:0=0D=0A
=0D=0A
          RX bytes:122 (122.0 B)  TX bytes:122 (122.0 B)=0D=0A
=0D=0A
 =0D=0A
=0D=0A
Running the raw packet analyzing program in the background (dumps bytes=0D=
=0A
to screen) and then invoking the UDP send program (INET, SOCK_DGRAM=0D=0A
socket) to send UDP packets to the pc running etherpeek, I see the=0D=0A
following ........=0D=0A
=0D=0A
 =0D=0A
=0D=0A
# udpSend 192.168.2.1 jjjj=0D=0A
=0D=0A
udpSend: sending data to '192.168.2.1' (IP : 192.168.2.1)=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
# ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 08 06 00 01 08 00 06 04=0D=0A
=0D=0A
00 01 00 10 ec 80 52 fc c0 a8=0D=0A
=0D=0A
02 02 00 00 00 00 00 00 c0 a8=0D=0A
=0D=0A
02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
Pkt Received of length 46:=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 81 00 00 02 08 06 00 01=0D=0A
=0D=0A
08 00 06 04 00 01 00 10 ec 80=0D=0A
=0D=0A
52 fc c0 a8 02 02 00 00 00 00=0D=0A
=0D=0A
00 00 c0 a8 02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 08 06 00 01 08 00 06 04=0D=0A
=0D=0A
00 01 00 10 ec 80 52 fc c0 a8=0D=0A
=0D=0A
02 02 00 00 00 00 00 00 c0 a8=0D=0A
=0D=0A
02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
Pkt Received of length 46:=0D=0A
=0D=0A
 =0D=0A
=0D=0A
ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 81 00 00 02 08 06 00 01=0D=0A
=0D=0A
08 00 06 04 00 01 00 10 ec 80=0D=0A
=0D=0A
52 fc c0 a8 02 02 00 00 00 00=0D=0A
=0D=0A
00 00 c0 a8 02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 08 06 00 01 08 00 06 04=0D=0A
=0D=0A
00 01 00 10 ec 80 52 fc c0 a8=0D=0A
=0D=0A
02 02 00 00 00 00 00 00 c0 a8=0D=0A
=0D=0A
02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
Pkt Received of length 46:=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
ff ff ff ff ff ff 00 10 ec 80=0D=0A
=0D=0A
52 fc 81 00 00 02 08 06 00 01=0D=0A
=0D=0A
08 00 06 04 00 01 00 10 ec 80=0D=0A
=0D=0A
52 fc c0 a8 02 02 00 00 00 00=0D=0A
=0D=0A
00 00 c0 a8 02 01=0D=0A
=0D=0A
Waiting for packets=0D=0A
=0D=0A
 =0D=0A
=0D=0A
Etherpeek doesn't show any info being received and the raw packet=0D=0A
analyzing program shows that the ARP and Vlan tagged ARP packets are=0D=0A
being seen on the receive side of the raw socket.=0D=0A
=0D=0A
The stats show that info is being transmitted out eth1.2 and the lo=0D=0A
stats increase in the rx and tx counts. The eth1 stats stay constant.=0D=0A
The counts you see in eth1 are from being previously configured and=0D=0A
sending/receiving data.=0D=0A
=0D=0A
 =0D=0A
=0D=0A
I expect VLAN tagged ARP packets to be seen at etherpeek but understand=0D=
=0A
that the UDP packet will not be seen as the pc interface has not setup=0D=
=0A
to be vlan tagged. Can anyone shed some light on what is going on here?=0D=
=0A
Are there problems with my vconfig/ifconfig settings? Are there hardware=0D=
=0A
problems that mean this can't be done?=0D=0A
=0D=0A
 =0D=0A
=0D=0A
......... Keith R=0D=0A
=0D=0A
 =0D=0A
=0D=0A
=0D=0A
Legal Disclaimer:=0A
The information contained in this message may be privileged and confident=
ial. It is intended to be read only by the individual or entity to whom i=
t is addressed or by their designee. If the reader of this message is not=
 the intended recipient, you are on notice that any distribution of this =
message, in any form, is strictly prohibited. If you have received this m=
essage in error, please immediately notify the sender and delete or destr=
oy any copy of this message=0D=0A

------_=_NextPart_001_01C6BAE6.F8508357
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">=0D=0A
=0D=0A
<head>=0D=0A
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">=0D=0A
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">=0D=
=0A
<style>=0D=0A
<!--=0D=0A
 /* Style Definitions */=0D=0A
 p.MsoNormal, li.MsoNormal, div.MsoNormal=0D=0A
	{margin:0cm;=0D=0A
	margin-bottom:.0001pt;=0D=0A
	font-size:12.0pt;=0D=0A
	font-family:"Times New Roman";}=0D=0A
a:link, span.MsoHyperlink=0D=0A
	{color:blue;=0D=0A
	text-decoration:underline;}=0D=0A
a:visited, span.MsoHyperlinkFollowed=0D=0A
	{color:purple;=0D=0A
	text-decoration:underline;}=0D=0A
span.EmailStyle17=0D=0A
	{mso-style-type:personal-compose;=0D=0A
	font-family:Arial;=0D=0A
	color:windowtext;}=0D=0A
@page Section1=0D=0A
	{size:612.0pt 792.0pt;=0D=0A
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}=0D=0A
div.Section1=0D=0A
	{page:Section1;}=0D=0A
-->=0D=0A
</style>=0D=0A
=0D=0A
</head>=0D=0A
=0D=0A
<body lang=3DEN-US link=3Dblue vlink=3Dpurple>=0D=0A
=0D=0A
<div class=3DSection1>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>The system that I am=
 using=0D=0A
is as follows.....<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Embedded Linux on a =
Motorola=0D=0A
852T processor with FEC support. Embedded Planet BSP<o:p></o:p></span></f=
ont></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Software that runs o=
n the=0D=0A
embedded processor to send UDP packets, via the FEC port (eth1), to a PC.=
 <o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>This PC is directly =
linked=0D=0A
to the FEC port with a cable and is running etherpeek.<o:p></o:p></span><=
/font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Software that runs o=
n the=0D=0A
embedded processor to listen to all received traffic at the FEC (uses RAW=
=0D=0A
packet socket).<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>802.1q Support has b=
een=0D=0A
enabled in the kernel. 802.1Q VLAN Support v1.8 Ben Greear=0D=0A
&lt;greearb@candelatech.com&gt;<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>The vlan configurati=
on that=0D=0A
I am applying is ......<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ifconfig eth1 d=
own<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ifconfig eth1 0=
.0.0.0=0D=0A
up<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; vconfig add eth=
1 2<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&gt; ifconfig eth1.2=
=0D=0A
192.168.2.2 up<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>After this is done i=
fconfig=0D=0A
returns the following .....<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># ifconfig<o:p></o:p=
></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Link=0D=0A
encap:Ethernet&nbsp; HWaddr 00:10:EC:00:52:FC<o:p></o:p></span></font></p=
>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet=0D=0A
addr:10.226.210.86&nbsp; Bcast:10.255.255.255&nbsp; Mask:255.0.0.0<o:p></=
o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING=0D=0A
MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:210599=0D=0A
errors:0 dropped:0 overruns:0 frame:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:0=0D=0A
errors:0 dropped:0 overruns:0 carrier:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0=0D=0A
txqueuelen:100<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:20804624=0D=0A
(19.8 MiB)&nbsp; TX bytes:0 (0.0 B)<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base=0D=0A
address:0x3e00<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Link=0D=0A
encap:Ethernet&nbsp; HWaddr 00:10:EC:80:52:FC<o:p></o:p></span></font></p=
>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST=0D=0A
RUNNING MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<o:p></o:p></span></font><=
/p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:64=0D=0A
errors:0 dropped:0 overruns:0 frame:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:2=0D=0A
errors:0 dropped:0 overruns:0 carrier:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0=0D=0A
txqueuelen:100<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:9055 (8.8=0D=0A
KiB)&nbsp; TX bytes:365 (365.0 B)<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Base address:0xe00<o:p></o:p></span></=
font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>eth1.2&nbsp;&nbsp;&n=
bsp; Link=0D=0A
encap:Ethernet&nbsp; HWaddr 00:10:EC:80:52:FC<o:p></o:p></span></font></p=
>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet=0D=0A
addr:192.168.2.2&nbsp; Bcast:192.168.2.255&nbsp; Mask:255.255.255.0<o:p><=
/o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING=0D=0A
MULTICAST&nbsp; MTU:1500&nbsp; Metric:1<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:0=0D=0A
errors:0 dropped:0 overruns:0 frame:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:6=0D=0A
errors:0 dropped:0 overruns:0 carrier:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0=0D=0A
txqueuelen:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 (0.0=0D=0A
B)&nbsp; TX bytes:276 (276.0 B)<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>lo&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Local=0D=0A
Loopback<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inet=0D=0A
addr:127.0.0.1&nbsp; Mask:255.0.0.0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOOPBACK=0D=0A
RUNNING&nbsp; MTU:16436&nbsp; Metric:1<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX packets:2=0D=0A
errors:0 dropped:0 overruns:0 frame:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX packets:2=0D=0A
errors:0 dropped:0 overruns:0 carrier:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; collisions:0=0D=0A
txqueuelen:0<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:122=0D=0A
(122.0 B)&nbsp; TX bytes:122 (122.0 B)<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Running the raw pack=
et=0D=0A
analyzing program in the background (dumps bytes to screen) and then invo=
king=0D=0A
the UDP send program (INET, SOCK_DGRAM socket) to send UDP packets to the=
 pc=0D=0A
running etherpeek, I see the following ........<o:p></o:p></span></font><=
/p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># udpSend 192.168.2.=
1 jjjj<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>udpSend: sending dat=
a to=0D=0A
'192.168.2.1' (IP : 192.168.2.1)<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'># ff ff ff ff ff ff =
00 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 08 06 00 01 08=
 00 06=0D=0A
04<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 01 00 10 ec 80 52=
 fc c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 02 00 00 00 00 00=
 00 c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 01<o:p></o:p></sp=
an></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Pkt Received of leng=
th 46:<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>ff ff ff ff ff ff 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 81 00 00 02 08=
 06 00=0D=0A
01<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>08 00 06 04 00 01 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc c0 a8 02 02 00=
 00 00=0D=0A
00<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 00 c0 a8 02 01<o:=
p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;=0D=0A
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>ff ff ff ff ff ff 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 08 06 00 01 08=
 00 06=0D=0A
04<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 01 00 10 ec 80 52=
 fc c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 02 00 00 00 00 00=
 00 c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 01<o:p></o:p></sp=
an></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Pkt Received of leng=
th 46:<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>ff ff ff ff ff ff 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 81 00 00 02 08=
 06 00=0D=0A
01<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>08 00 06 04 00 01 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc c0 a8 02 02 00=
 00 00=0D=0A
00<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 00 c0 a8 02 01<o:=
p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D=0A
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>ff ff ff ff ff ff 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 08 06 00 01 08=
 00 06=0D=0A
04<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 01 00 10 ec 80 52=
 fc c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 02 00 00 00 00 00=
 00 c0=0D=0A
a8<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>02 01<o:p></o:p></sp=
an></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Pkt Received of leng=
th 46:<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>ff ff ff ff ff ff 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc 81 00 00 02 08=
 06 00=0D=0A
01<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>08 00 06 04 00 01 00=
 10 ec=0D=0A
80<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>52 fc c0 a8 02 02 00=
 00 00=0D=0A
00<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>00 00 c0 a8 02 01<o:=
p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Waiting for packets<=
o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>Etherpeek doesn't sh=
ow any=0D=0A
info being received and the raw packet analyzing program shows that the A=
RP and=0D=0A
Vlan tagged ARP packets are being seen on the receive side of the raw soc=
ket.<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>The stats show that =
info is=0D=0A
being transmitted out eth1.2 and the lo stats increase in the rx and tx c=
ounts.=0D=0A
The eth1 stats stay constant. The counts you see in eth1 are from being=0D=
=0A
previously configured and sending/receiving data.<o:p></o:p></span></font=
></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>I expect VLAN tagged=
 ARP=0D=0A
packets to be seen at etherpeek but understand that the UDP packet will n=
ot be=0D=0A
seen as the pc interface has not setup to be vlan tagged. Can anyone shed=
 some=0D=0A
light on what is going on here? Are there problems with my vconfig/ifconf=
ig=0D=0A
settings? Are there hardware problems that mean this can&#8217;t be done?=
<o:p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></s=
pan></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D=
"Courier New"><span=0D=0A
style=3D'font-size:10.0pt;font-family:"Courier New"'>......... Keith R<o:=
p></o:p></span></font></p>=0D=0A
=0D=0A
<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:=0D=0A
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>=0D=0A
=0D=0A
</div>=0D=0A
=0D=0A
Legal Disclaimer:=0A
The information contained in this message may be privileged and confident=
ial. It is intended to be read only by the individual or entity to whom i=
t is addressed or by their designee. If the reader of this message is not=
 the intended recipient, you are on notice that any distribution of this =
message, in any form, is strictly prohibited. If you have received this m=
essage in error, please immediately notify the sender and delete or destr=
oy any copy of this message</body>=0D=0A
=0D=0A
</html>=0D=0A

------_=_NextPart_001_01C6BAE6.F8508357--
