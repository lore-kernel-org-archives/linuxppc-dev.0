Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C0BFBDDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 03:34:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C755D5.46B69ECD"
Subject: RE: enabling two eths
Date: Wed, 21 Feb 2007 11:28:10 -0500
Message-ID: <556445368AFA1C438794ABDA8901891C03445716@usa0300ms03.na.xerox.net>
In-Reply-To: <OFEDE45104.191EF09D-ON65257289.001981AA-65257289.001A6E1E@lntemsys.com>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Manjunath AM" <Manjunath.AM@Lntemsys.com>,
	"Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C755D5.46B69ECD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Send the results of=20
ifconfig
and
route -n
=20
I take it eth0 works fine...
=20
Have you tried swapping the assignments and see if eth1 works (to
eliminate faulty hardware).
=20
marty


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
=09
=09


------_=_NextPart_001_01C755D5.46B69ECD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D616512416-21022007></SPAN><FONT face=3DArial><FONT=20
color=3D#0000ff><FONT size=3D2>Send&nbsp;the&nbsp;results&nbsp;of=20
</FONT></FONT></FONT></DIV>
<DIV><FONT><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D616512416-21022007></SPAN></FONT></FONT></FONT><SPAN=20
class=3D616512416-21022007></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
size=3D2>i<SPAN =
class=3D616512416-21022007>fconfig</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D616512416-21022007></SPAN></FONT></FONT></FONT><SPAN=20
class=3D616512416-21022007></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
size=3D2>a<SPAN =
class=3D616512416-21022007>nd</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D616512416-21022007></SPAN></FONT></FONT></FONT><SPAN=20
class=3D616512416-21022007></SPAN><FONT face=3DArial><FONT =
color=3D#0000ff><FONT=20
size=3D2>r<SPAN class=3D616512416-21022007>oute =
-n</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><FONT size=3D2><SPAN=20
class=3D616512416-21022007></SPAN></FONT></FONT></FONT><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D616512416-21022007><FONT face=3DArial color=3D#0000ff =
size=3D2>I take=20
it eth0 works fine...</FONT></SPAN></DIV>
<DIV><SPAN class=3D616512416-21022007><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D616512416-21022007><FONT face=3DArial color=3D#0000ff =
size=3D2>Have=20
you tried swapping the assignments and see if eth1 works (to eliminate =
faulty=20
hardware).</FONT></SPAN></DIV>
<DIV><SPAN class=3D616512416-21022007><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D616512416-21022007><FONT face=3DArial color=3D#0000ff =

size=3D2>marty</FONT></SPAN></DIV>
<DIV><BR></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B>=20
  linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org=20
  =
[mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org] =
<B>On=20
  Behalf Of </B>Manjunath AM<BR><B>Sent:</B> Tuesday, February 20, 2007 =
11:50=20
  PM<BR><B>To:</B> Vitaly Bordug<BR><B>Cc:</B>=20
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Re: enabling two=20
  eths<BR></FONT><BR></DIV>
  <DIV></DIV><BR><FONT face=3Dsans-serif size=3D2>Hi, Thanks for your =
kind reply,=20
  Yes i have used different * IP Subnets*</FONT> <BR><BR><FONT =
face=3Dsans-serif=20
  size=3D2>The IPs and subnet details I use is</FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>1. eth0(configured through u-boot env settings)-&gt;&gt;=20
  192.168.174.231 and subnet is 255.255.255.0 </FONT><BR><FONT =
face=3Dsans-serif=20
  size=3D2>2. eth1(configured after kernel is up)--&gt; 192.168.33.64 =
and subnet=20
  is 255.255.248.0</FONT> <BR><BR><FONT face=3Dsans-serif size=3D2>Even =
i tried by=20
  connecting second eth to host PC using cross cable as a stand-alone =
network=20
  but even "ping" did not work.. </FONT><BR><BR><BR><BR><FONT =
face=3Dsans-serif=20
  size=3D2>Thanks &amp; Regards<BR>MANJUNATH AM<BR>Senior Software=20
  Engineer<BR>Emsys<BR>Larsen &amp; Toubro=20
  Limited<BR>Mysore-570018<BR>Mobile:9886375926<BR></FONT><BR><BR><BR>
  <TABLE width=3D"100%">
    <TBODY>
    <TR vAlign=3Dtop>
      <TD width=3D"40%"><FONT face=3Dsans-serif size=3D1><B>Vitaly =
Bordug=20
        &lt;vbordug@ru.mvista.com&gt;</B> </FONT>
        <P><FONT face=3Dsans-serif size=3D1>02/20/2007 09:30 PM</FONT> =
</P>
      <TD width=3D"59%">
        <TABLE width=3D"100%">
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>To</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>Alex Zeffertt=20
              &lt;ajz@cambridgebroadband.com&gt;</FONT>=20
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>cc</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>Manjunath AM=20
              &lt;Manjunath.AM@Lntemsys.com&gt;,=20
              linuxppc-embedded@ozlabs.org</FONT>=20
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>Subject</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>Re: enabling two=20
          eths</FONT></TR></TBODY></TABLE><BR>
        <TABLE>
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
            =
<TD></TR></TBODY></TABLE><BR></TR></TBODY></TABLE><BR><BR><BR><FONT=20
  size=3D2><TT>On Tue, 20 Feb 2007 15:31:54 +0000<BR>Alex Zeffertt=20
  &lt;ajz@cambridgebroadband.com&gt; wrote:<BR><BR>&gt; <BR>&gt; =
Manjunath AM=20
  wrote:<BR>&gt; &gt; <BR>&gt; &gt; Hi,<BR>&gt; &gt; <BR>&gt; &gt; We =
are using=20
  MPC8272 based target board, we use montavista Linux version <BR>&gt; =
&gt;=20
  2.6.10 kernel image (with NFS enabled) to our target board,<BR>&gt; =
&gt;=20
  <BR>&gt; &gt; Our board has &nbsp;2 FCCs (eth0 and eth1). bot the =
eth's works=20
  perfectly <BR>&gt; &gt; when we use them independently, but when we =
are trying=20
  to enable second <BR>&gt; &gt; one after the kernel is up using linux =
command=20
  &nbsp;"ifconfig eth1 <BR>&gt; &gt; 192.168.33.64 up"(IP =
address)nothing is=20
  working.<BR>&gt; &gt; Please suggest how to enable second eth (either =
0 or 1)=20
  once the kernel <BR>&gt; &gt; is up with NFS file system<BR>&gt; =
<BR>&gt;=20
  <BR>&gt; Have you made sure that eth0 and eth1 are on *different* IP=20
  subnets?<BR>&gt; If they are on the same subnet, or intersecting =
subnets, your=20
  routing<BR>&gt; will get confused.<BR>&gt; <BR>It depends :)<BR><BR>I =
used to=20
  test functionality such a way to have two enets in same subnet, then =
ifdown=20
  one of them.<BR><BR>At least with mvista RFS, one enet &nbsp;handles =
NFS,=20
  other is up but all the packets are routed to it via<BR>the first one. =
And=20
  when the first one got ifdown, routing switches to the remaining =
enet...<BR>--=20
  <BR>Sincerely, =
<BR>Vitaly<BR></TT></FONT><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C755D5.46B69ECD--
