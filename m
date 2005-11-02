Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 3B92E68658
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Nov 2005 22:28:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5DFA0.7C1E0493"
Date: Wed, 2 Nov 2005 03:28:02 -0800
Message-ID: <F795765B112E7344AF36AA91127964158496E9@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <mcr@marajade.sandelman.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: compact flash driver
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

------_=_NextPart_001_01C5DFA0.7C1E0493
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>>>>> "Alex" =3D=3D Alex Zeffertt <ajz@cambridgebroadband.com> writes:

>> Hello All, Are there any compact flash driver supported for Linux

>> 2.6? If there is where can i get the source code. Thanks, Bizhan

>>=20

Alex> I think that CF cards just get treated the same as any other

Alex> IDE disk by linux. No special driver needed.

>Yes. There are some gotchas with newer pcmcia/cardbus flash cards.

>For instance, Silicon Systems devices claim to support IORDY, but
don't, which results in a system hang. I imagine that the same >kind of
things will show up in newer CF devices, although I think that CF can't
support DMA.

>It also depends upon how you interface CF: via an IDE controller, or
via a cardbus interface.

>I expect to have a git tree with stuff available soon.

Do you have an early release code? I can start to work at.

Many thanks in advance,

Bizhan


------_=_NextPart_001_01C5DFA0.7C1E0493
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<P><FONT face=3DArial size=3D2>&gt;&gt;&gt;&gt;&gt; "Alex" =3D=3D Alex =
Zeffertt=20
&lt;ajz@cambridgebroadband.com&gt; writes:</FONT></P>
<P><FONT face=3DArial size=3D2>&gt;&gt; Hello All, Are there any compact =
flash=20
driver supported for Linux</FONT></P>
<P><FONT face=3DArial size=3D2>&gt;&gt; 2.6? If there is where can i get =
the source=20
code. Thanks, Bizhan</FONT></P>
<P><FONT face=3DArial size=3D2>&gt;&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>Alex&gt; I think that CF cards just get =
treated the=20
same as any other</FONT></P>
<P><FONT face=3DArial size=3D2>Alex&gt; IDE disk by linux. No special =
driver=20
needed.</FONT></P>
<P><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D487392411-02112005>&gt;</SPAN>Yes.=20
There are some gotchas with newer pcmcia/cardbus flash =
cards.</FONT></FONT></P>
<P><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D487392411-02112005>&gt;</SPAN>For=20
instance, Silicon Systems devices claim to support IORDY, but don't, =
which=20
results in a system hang. I imagine that the same&nbsp;<SPAN=20
class=3D487392411-02112005>&gt;</SPAN>kind of things will show up in =
newer CF=20
devices, although I think that CF can't support DMA.</FONT></FONT></P>
<P><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D487392411-02112005>&gt;</SPAN>It=20
also depends upon how you interface CF: via an IDE controller, or via a =
cardbus=20
interface.</FONT></FONT></P>
<P><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D487392411-02112005>&gt;</SPAN>I=20
expect to have a git tree with stuff available soon.</FONT></FONT></P>
<P><SPAN class=3D487392411-02112005><FONT face=3DArial size=3D2>Do you =
have an early=20
release code? I can start to work at.</FONT></SPAN></P>
<P><SPAN class=3D487392411-02112005><FONT face=3DArial size=3D2>Many =
thanks in=20
advance,</FONT></SPAN></P>
<P><SPAN class=3D487392411-02112005><FONT face=3DArial=20
size=3D2>Bizhan</FONT></SPAN></P></DIV></BODY></HTML>

------_=_NextPart_001_01C5DFA0.7C1E0493--
