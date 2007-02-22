Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler3.mail.xerox.com (wvmler3.mail.xerox.com [13.8.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler3.mail.xerox.com",
	Issuer "wvmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E5164DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 07:39:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756C1.7470D8E4"
Subject: RE: enabling two eths
Date: Thu, 22 Feb 2007 15:38:48 -0500
Message-ID: <556445368AFA1C438794ABDA8901891C03445720@usa0300ms03.na.xerox.net>
In-Reply-To: <OFBE288479.DC0A765B-ON6525728A.0017B972-6525728A.00180C87@lntemsys.com>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Manjunath AM" <Manjunath.AM@Lntemsys.com>
Cc: linuxppc-embedded-bounces+manjunath.am=lntemsys.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C756C1.7470D8E4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

so eth1 works but eth0 doesn't?
=20
what's interesting is here you have no tx/rx/error packets -- how do you
know its not working?
=20
Are there machines on this subnet which are working?
=20
Also ping into the machine...
=20
Its also sometimes useful to have a hub (not a switch) and sniff the
packets...
=20
marty
=20


________________________________

	From: Manjunath AM [mailto:Manjunath.AM@Lntemsys.com]=20
	Sent: Wednesday, February 21, 2007 11:24 PM
	To: Leisner, Martin
	Cc: linuxppc-embedded@ozlabs.org;
linuxppc-embedded-bounces+manjunath.am=3Dlntemsys.com@ozlabs.org; Vitaly
Bordug
	Subject: RE: enabling two eths
=09
=09

	Hi Martin,=20
=09
	Thanks for your reply,Yes I tried swapping the assignments,same
thing is happening in both cases..ifconfig and route -n results are as
below:=20
=09
=09
	ifconfig=20
=09
	eth0      Link encap:Ethernet  HWaddr 00:99:23:C4:AD:DE=20
	          inet addr:192.168.33.64  Bcast:192.168.33.255
Mask:255.255.248.0=20
	          inet6 addr: fe80::299:23ff:fec4:adde/64 Scope:Link=20
	          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=20
	          RX packets:0 errors:0 dropped:0 overruns:0 frame:0=20
	          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0=20
	          collisions:0 txqueuelen:1000=20
	          RX bytes:0 (0.0 b)  TX bytes:308 (308.0 b)=20
	          Base address:0x8400=20
=09
	eth1      Link encap:Ethernet  HWaddr 00:99:23:44:AD:DE=20
	          inet addr:192.168.178.124  Bcast:192.168.178.255
Mask:255.255.255.0=20
	          inet6 addr: fe80::299:23ff:fe44:adde/64 Scope:Link=20
	          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1=20
	          RX packets:22790 errors:0 dropped:0 overruns:0 frame:0

	          TX packets:9218 errors:0 dropped:0 overruns:0
carrier:8830=20
	          collisions:0 txqueuelen:1000=20
	          RX bytes:14916045 (14.2 MiB)  TX bytes:1463093 (1.3
MiB)=20
	          Base address:0x8500=20
=09
	lo        Link encap:Local Loopback=20
	          inet6 addr: ::1/128 Scope:Host=20
	          UP LOOPBACK RUNNING  MTU:16436  Metric:1=20
	          RX packets:0 errors:0 dropped:0 overruns:0 frame:0=20
	          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0=20
	          collisions:0 txqueuelen:0=20
	          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)=20
=09
	route -n=20
	Destination     Gateway         Genmask         Flags Metric Ref
Use Iface=20
	192.168.178.0   0.0.0.0         255.255.255.0   U     0      0
0 eth1=20
	192.168.32.0    0.0.0.0         255.255.248.0   U     0      0
0 eth0=20
	0.0.0.0         192.168.178.47  0.0.0.0         UG    0      0
0 eth1=20
=09
=09
=09
	Thanks & Regards
	MANJUNATH AM
	Senior Software Engineer
	Emsys
	Larsen & Toubro Limited
	Mysore-570018
	Mobile:9886375926
=09
=09
=09
=09
"Leisner, Martin" <Martin.Leisner@xerox.com>=20
Sent by: =
linuxppc-embedded-bounces+manjunath.am=3Dlntemsys.com@ozlabs.org=20

02/21/2007 09:58 PM=20

To
"Manjunath AM" <Manjunath.AM@Lntemsys.com>, "Vitaly Bordug"
<vbordug@ru.mvista.com>=20
cc
linuxppc-embedded@ozlabs.org=20
Subject
RE: enabling two eths

=09




	 =20
	Send the results of=20
	ifconfig=20
	and=20
	route -n=20
	 =20
	I take it eth0 works fine...=20
	 =20
	Have you tried swapping the assignments and see if eth1 works
(to eliminate faulty hardware).=20
	 =20
	marty=20
=09
=09
________________________________

	From:
linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org]
On Behalf Of Manjunath AM
	Sent: Tuesday, February 20, 2007 11:50 PM
	To: Vitaly Bordug
	Cc: linuxppc-embedded@ozlabs.org
	Subject: Re: enabling two eths
=09
=09
	Hi, Thanks for your kind reply, Yes i have used different * IP
Subnets*=20
=09
	The IPs and subnet details I use is=20
	1. eth0(configured through u-boot env settings)->>
192.168.174.231 and subnet is 255.255.255.0=20
	2. eth1(configured after kernel is up)--> 192.168.33.64 and
subnet is 255.255.248.0=20
=09
	Even i tried by connecting second eth to host PC using cross
cable as a stand-alone network but even "ping" did not work..=20
=09
=09
=09
	Thanks & Regards
	MANJUNATH AM
	Senior Software Engineer
	Emsys
	Larsen & Toubro Limited
	Mysore-570018
	Mobile:9886375926
=09
=09
=09
Vitaly Bordug <vbordug@ru.mvista.com>=20

02/20/2007 09:30 PM=20



To
Alex Zeffertt <ajz@cambridgebroadband.com>=20
cc
Manjunath AM <Manjunath.AM@Lntemsys.com>, linuxppc-embedded@ozlabs.org=20
Subject
Re: enabling two eths


=09


=09
=09
=09
	On Tue, 20 Feb 2007 15:31:54 +0000
	Alex Zeffertt <ajz@cambridgebroadband.com> wrote:
=09
	>=20
	> Manjunath AM wrote:
	> >=20
	> > Hi,
	> >=20
	> > We are using MPC8272 based target board, we use montavista
Linux version=20
	> > 2.6.10 kernel image (with NFS enabled) to our target board,
	> >=20
	> > Our board has  2 FCCs (eth0 and eth1). bot the eth's works
perfectly=20
	> > when we use them independently, but when we are trying to
enable second=20
	> > one after the kernel is up using linux command  "ifconfig
eth1=20
	> > 192.168.33.64 up"(IP address)nothing is working.
	> > Please suggest how to enable second eth (either 0 or 1) once
the kernel=20
	> > is up with NFS file system
	>=20
	>=20
	> Have you made sure that eth0 and eth1 are on *different* IP
subnets?
	> If they are on the same subnet, or intersecting subnets, your
routing
	> will get confused.
	>=20
	It depends :)
=09
	I used to test functionality such a way to have two enets in
same subnet, then ifdown one of them.
=09
	At least with mvista RFS, one enet  handles NFS, other is up but
all the packets are routed to it via
	the first one. And when the first one got ifdown, routing
switches to the remaining enet...
	--=20
	Sincerely,=20
	Vitaly
	_______________________________________________
	Linuxppc-embedded mailing list
	Linuxppc-embedded@ozlabs.org
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded=20
=09


------_=_NextPart_001_01C756C1.7470D8E4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>so eth1 works but eth0 =
doesn't?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>what's interesting is here you have no =
tx/rx/error packets=20
-- how do you know its not working?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Are there machines on this subnet which are=20
working?</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Also ping into the =
machine...</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Its also sometimes useful to have a hub (not a =
switch) and=20
sniff the packets...</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>marty</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D670553620-22022007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> Manjunath AM=20
  [mailto:Manjunath.AM@Lntemsys.com] <BR><B>Sent:</B> Wednesday, =
February 21,=20
  2007 11:24 PM<BR><B>To:</B> Leisner, Martin<BR><B>Cc:</B>=20
  linuxppc-embedded@ozlabs.org;=20
  linuxppc-embedded-bounces+manjunath.am=3Dlntemsys.com@ozlabs.org; =
Vitaly=20
  Bordug<BR><B>Subject:</B> RE: enabling two eths<BR></FONT><BR></DIV>
  <DIV></DIV><BR><FONT face=3Dsans-serif size=3D2>Hi Martin,</FONT> =
<BR><BR><FONT=20
  face=3Dsans-serif size=3D2>Thanks for your reply,Yes I tried swapping =
the=20
  assignments,same thing is happening in both cases..ifconfig and route =
-n=20
  results are as below:</FONT> <BR><BR><BR><FONT face=3DArial =
color=3Dblue=20
  size=3D2><B>ifconfig</B></FONT> <BR><BR><FONT face=3Dsans-serif =
size=3D2>eth0 &nbsp;=20
  &nbsp; &nbsp;Link encap:Ethernet &nbsp;HWaddr 00:99:23:C4:AD:DE</FONT> =

  <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; inet=20
  addr:192.168.33.64 &nbsp;Bcast:192.168.33.255 =
&nbsp;Mask:255.255.248.0</FONT>=20
  <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; inet6=20
  addr: fe80::299:23ff:fec4:adde/64 Scope:Link</FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP BROADCAST RUNNING =
MULTICAST=20
  &nbsp;MTU:1500 &nbsp;Metric:1</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
  &nbsp; &nbsp; &nbsp; &nbsp; RX packets:0 errors:0 dropped:0 overruns:0 =

  frame:0</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
  &nbsp; TX packets:0 errors:0 dropped:0 overruns:0 carrier:0</FONT> =
<BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
collisions:0=20
  txqueuelen:1000</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; =
&nbsp; &nbsp;=20
  &nbsp; &nbsp; RX bytes:0 (0.0 b) &nbsp;TX bytes:308 (308.0 b)</FONT> =
<BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Base=20
  address:0x8400</FONT> <BR><BR><FONT face=3Dsans-serif size=3D2>eth1 =
&nbsp; &nbsp;=20
  &nbsp;Link encap:Ethernet &nbsp;HWaddr 00:99:23:44:AD:DE</FONT> =
<BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet=20
  addr:192.168.178.124 &nbsp;Bcast:192.168.178.255=20
  &nbsp;Mask:255.255.255.0</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp; &nbsp;=20
  &nbsp; &nbsp; &nbsp; inet6 addr: fe80::299:23ff:fe44:adde/64 =
Scope:Link</FONT>=20
  <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; UP=20
  BROADCAST RUNNING MULTICAST &nbsp;MTU:1500 &nbsp;Metric:1</FONT> =
<BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX =
packets:22790=20
  errors:0 dropped:0 overruns:0 frame:0</FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX packets:9218 errors:0 =
dropped:0=20
  overruns:0 carrier:8830</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp; &nbsp;=20
  &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:1000</FONT> <BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX =
bytes:14916045=20
  (14.2 MiB) &nbsp;TX bytes:1463093 (1.3 MiB)</FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Base address:0x8500</FONT> =

  <BR><BR><FONT face=3Dsans-serif size=3D2>lo &nbsp; &nbsp; &nbsp; =
&nbsp;Link=20
  encap:Local Loopback</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp; &nbsp;=20
  &nbsp; &nbsp; &nbsp; inet6 addr: ::1/128 Scope:Host</FONT> <BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP =
LOOPBACK RUNNING=20
  &nbsp;MTU:16436 &nbsp;Metric:1</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>&nbsp;=20
  &nbsp; &nbsp; &nbsp; &nbsp; RX packets:0 errors:0 dropped:0 overruns:0 =

  frame:0</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp; &nbsp;=20
  &nbsp; TX packets:0 errors:0 dropped:0 overruns:0 carrier:0</FONT> =
<BR><FONT=20
  face=3Dsans-serif size=3D2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
collisions:0=20
  txqueuelen:0</FONT> <BR><FONT face=3Dsans-serif size=3D2>&nbsp; &nbsp; =
&nbsp;=20
  &nbsp; &nbsp; RX bytes:0 (0.0 b) &nbsp;TX bytes:0 (0.0 b)</FONT> =
<BR><BR><FONT=20
  face=3DArial color=3Dblue size=3D2><B>route -n</B></FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>Destination &nbsp; &nbsp; Gateway &nbsp; &nbsp; &nbsp; &nbsp; =
Genmask=20
  &nbsp; &nbsp; &nbsp; &nbsp; Flags Metric Ref &nbsp; &nbsp;Use =
Iface</FONT>=20
  <BR><FONT face=3Dsans-serif size=3D2>192.168.178.0 &nbsp; 0.0.0.0 =
&nbsp; &nbsp;=20
  &nbsp; &nbsp; 255.255.255.0 &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp; =
&nbsp;0=20
  &nbsp; &nbsp; &nbsp; &nbsp;0 eth1</FONT> <BR><FONT face=3Dsans-serif=20
  size=3D2>192.168.32.0 &nbsp; &nbsp;0.0.0.0 &nbsp; &nbsp; &nbsp; &nbsp; =

  255.255.248.0 &nbsp; U &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp;0 &nbsp; =
&nbsp;=20
  &nbsp; &nbsp;0 eth0</FONT> <BR><FONT face=3Dsans-serif =
size=3D2>0.0.0.0 &nbsp;=20
  &nbsp; &nbsp; &nbsp; 192.168.178.47 &nbsp;0.0.0.0 &nbsp; &nbsp; &nbsp; =
&nbsp;=20
  UG &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0=20
  eth1</FONT> <BR><BR><BR><BR><FONT face=3Dsans-serif size=3D2>Thanks =
&amp;=20
  Regards<BR>MANJUNATH AM<BR>Senior Software Engineer<BR>Emsys<BR>Larsen =
&amp;=20
  Toubro =
Limited<BR>Mysore-570018<BR>Mobile:9886375926<BR></FONT><BR><BR><BR>
  <TABLE width=3D"100%">
    <TBODY>
    <TR vAlign=3Dtop>
      <TD width=3D"40%"><FONT face=3Dsans-serif size=3D1><B>"Leisner, =
Martin"=20
        &lt;Martin.Leisner@xerox.com&gt;</B> </FONT><BR><FONT =
face=3Dsans-serif=20
        size=3D1>Sent by:=20
        =
linuxppc-embedded-bounces+manjunath.am=3Dlntemsys.com@ozlabs.org</FONT>=20
        <P><FONT face=3Dsans-serif size=3D1>02/21/2007 09:58 PM</FONT> =
</P>
      <TD width=3D"59%">
        <TABLE width=3D"100%">
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>To</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>"Manjunath AM"=20
              &lt;Manjunath.AM@Lntemsys.com&gt;, "Vitaly Bordug"=20
              &lt;vbordug@ru.mvista.com&gt;</FONT>=20
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>cc</FONT></DIV>
            <TD><FONT face=3Dsans-serif=20
              size=3D1>linuxppc-embedded@ozlabs.org</FONT>=20
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>Subject</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>RE: enabling two=20
          eths</FONT></TR></TBODY></TABLE><BR>
        <TABLE>
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
            =
<TD></TR></TBODY></TABLE><BR></TR></TBODY></TABLE><BR><BR><BR><FONT=20
  size=3D3>&nbsp;</FONT> <BR><FONT face=3DArial color=3Dblue =
size=3D2>Send the results=20
  of </FONT><BR><FONT face=3DArial color=3Dblue size=3D2>ifconfig</FONT> =
<BR><FONT=20
  face=3DArial color=3Dblue size=3D2>and</FONT> <BR><FONT face=3DArial =
color=3Dblue=20
  size=3D2>route -n</FONT> <BR><FONT size=3D3>&nbsp;</FONT> <BR><FONT =
face=3DArial=20
  color=3Dblue size=3D2>I take it eth0 works fine...</FONT> <BR><FONT=20
  size=3D3>&nbsp;</FONT> <BR><FONT face=3DArial color=3Dblue =
size=3D2>Have you tried=20
  swapping the assignments and see if eth1 works (to eliminate faulty=20
  hardware).</FONT> <BR><FONT size=3D3>&nbsp;</FONT> <BR><FONT =
face=3DArial=20
  color=3Dblue size=3D2>marty</FONT> <BR><BR>
  <HR>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Manjunath AM<B><BR>Sent:</B> Tuesday, February 20, 2007 =
11:50=20
  PM<B><BR>To:</B> Vitaly Bordug<B><BR>Cc:</B>=20
  linuxppc-embedded@ozlabs.org<B><BR>Subject:</B> Re: enabling two=20
  eths</FONT><FONT size=3D3><BR></FONT><BR><FONT face=3Dsans-serif =
size=3D2><BR>Hi,=20
  Thanks for your kind reply, Yes i have used different * IP=20
  Subnets*</FONT><FONT size=3D3> <BR></FONT><FONT face=3Dsans-serif =
size=3D2><BR>The=20
  IPs and subnet details I use is</FONT><FONT size=3D3> </FONT><FONT=20
  face=3Dsans-serif size=3D2><BR>1. eth0(configured through u-boot env=20
  settings)-&gt;&gt; 192.168.174.231 and subnet is 255.255.255.0 <BR>2.=20
  eth1(configured after kernel is up)--&gt; 192.168.33.64 and subnet is=20
  255.255.248.0</FONT><FONT size=3D3> <BR></FONT><FONT face=3Dsans-serif =

  size=3D2><BR>Even i tried by connecting second eth to host PC using =
cross cable=20
  as a stand-alone network but even "ping" did not work.. </FONT><FONT=20
  size=3D3><BR><BR><BR></FONT><FONT face=3Dsans-serif =
size=3D2><BR>Thanks &amp;=20
  Regards<BR>MANJUNATH AM<BR>Senior Software Engineer<BR>Emsys<BR>Larsen =
&amp;=20
  Toubro Limited<BR>Mysore-570018<BR>Mobile:9886375926</FONT><FONT=20
  size=3D3><BR><BR><BR></FONT>
  <TABLE width=3D"100%">
    <TBODY>
    <TR vAlign=3Dtop>
      <TD width=3D"34%"><FONT face=3Dsans-serif size=3D1><B>Vitaly =
Bordug=20
        &lt;vbordug@ru.mvista.com&gt;</B> </FONT>
        <P><FONT face=3Dsans-serif size=3D1>02/20/2007 09:30 =
PM</FONT><FONT size=3D3>=20
        </FONT></P>
      <TD width=3D"65%"><BR>
        <TABLE width=3D"100%">
          <TBODY>
          <TR vAlign=3Dtop>
            <TD width=3D"8%">
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>To</FONT></DIV>
            <TD width=3D"91%"><FONT face=3Dsans-serif size=3D1>Alex =
Zeffertt=20
              &lt;ajz@cambridgebroadband.com&gt;</FONT><FONT size=3D3> =
</FONT>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>cc</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>Manjunath AM=20
              &lt;Manjunath.AM@Lntemsys.com&gt;,=20
              linuxppc-embedded@ozlabs.org</FONT><FONT size=3D3> </FONT>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>Subject</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>Re: enabling two=20
          eths</FONT></TR></TBODY></TABLE><BR><BR>
        <TABLE width=3D"100%">
          <TBODY>
          <TR vAlign=3Dtop>
            <TD width=3D"50%">
            <TD =
width=3D"50%"></TR></TBODY></TABLE><BR></TR></TBODY></TABLE><BR><FONT=20
  size=3D3><BR><BR></FONT><FONT size=3D2><TT><BR>On Tue, 20 Feb 2007 =
15:31:54=20
  +0000<BR>Alex Zeffertt &lt;ajz@cambridgebroadband.com&gt; =
wrote:<BR><BR>&gt;=20
  <BR>&gt; Manjunath AM wrote:<BR>&gt; &gt; <BR>&gt; &gt; Hi,<BR>&gt; =
&gt;=20
  <BR>&gt; &gt; We are using MPC8272 based target board, we use =
montavista Linux=20
  version <BR>&gt; &gt; 2.6.10 kernel image (with NFS enabled) to our =
target=20
  board,<BR>&gt; &gt; <BR>&gt; &gt; Our board has &nbsp;2 FCCs (eth0 and =
eth1).=20
  bot the eth's works perfectly <BR>&gt; &gt; when we use them =
independently,=20
  but when we are trying to enable second <BR>&gt; &gt; one after the =
kernel is=20
  up using linux command &nbsp;"ifconfig eth1 <BR>&gt; &gt; =
192.168.33.64 up"(IP=20
  address)nothing is working.<BR>&gt; &gt; Please suggest how to enable =
second=20
  eth (either 0 or 1) once the kernel <BR>&gt; &gt; is up with NFS file=20
  system<BR>&gt; <BR>&gt; <BR>&gt; Have you made sure that eth0 and eth1 =
are on=20
  *different* IP subnets?<BR>&gt; If they are on the same subnet, or=20
  intersecting subnets, your routing<BR>&gt; will get confused.<BR>&gt; =
<BR>It=20
  depends :)<BR><BR>I used to test functionality such a way to have two =
enets in=20
  same subnet, then ifdown one of them.<BR><BR>At least with mvista RFS, =
one=20
  enet &nbsp;handles NFS, other is up but all the packets are routed to =
it=20
  via<BR>the first one. And when the first one got ifdown, routing =
switches to=20
  the remaining enet...<BR>-- <BR>Sincerely, <BR>Vitaly</TT></FONT><FONT =

  size=3D3><BR></FONT><FONT=20
  =
size=3D2><TT>_______________________________________________<BR>Linuxppc-=
embedded=20
  mailing=20
  =
list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listin=
fo/linuxppc-embedded</TT></FONT>=20
  <BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C756C1.7470D8E4--
