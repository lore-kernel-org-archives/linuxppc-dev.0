Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id AFCB1DDE98
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 16:10:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C854D9.81C15FC7"
Subject: RE: Device Tree & PCI
Date: Fri, 11 Jan 2008 23:08:14 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D2@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
	<20080111190215.GA10857@loki.buserror.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C854D9.81C15FC7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>From: Scott Wood
>Sent: Fri 1/11/2008 1:02 PM
>To: Rune Torgersen
>Cc: linuxppc-dev@ozlabs.org
>Subject: Re: Device Tree & PCI
>=20
>On Fri, Jan 11, 2008 at 12:17:41PM -0600, Rune Torgersen wrote:
>> 		PCI_INT: pic@5,10 {
>> 			#interrupt-cells =3D <1>;
>> 			interrupt-controller;
>> 			reg =3D <5 10 4>;                             //
>> Chip select, offset, length
>> 			compatible =3D "apmax-pciintmux";
>> 			interrupt-parent =3D <&PIC>;
>> 			interrupts =3D <19 8>;                        //
>> IRQ7, interrupt#25
>> 		};
>
>Is this interrupt controller getting registered before the PCI bus gets
>probed?

Yes, and we got the disk controller on the primary side to work fully.
The kernel is still spitting those messages out, and we have determined =
it does so when scanning the secondary side of the bridge, so we're =
suspecting our bridge node in the device tree is not correct.


------_=_NextPart_001_01C854D9.81C15FC7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Device Tree &amp; PCI</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt;From: Scott Wood<BR>
&gt;Sent: Fri 1/11/2008 1:02 PM<BR>
&gt;To: Rune Torgersen<BR>
&gt;Cc: linuxppc-dev@ozlabs.org<BR>
&gt;Subject: Re: Device Tree &amp; PCI<BR>
&gt;<BR>
&gt;On Fri, Jan 11, 2008 at 12:17:41PM -0600, Rune Torgersen wrote:<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI_INT: pic@5,10 {<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;1&gt;;<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-controller;<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;5 10 =
4&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; //<BR>
&gt;&gt; Chip select, offset, length<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;apmax-pciintmux&quot;;<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;PIC&gt;;<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;19 =
8&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//<BR>
&gt;&gt; IRQ7, interrupt#25<BR>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&gt;<BR>
&gt;Is this interrupt controller getting registered before the PCI bus =
gets<BR>
&gt;probed?<BR>
<BR>
Yes, and we got the disk controller on the primary side to work =
fully.<BR>
The kernel is still spitting those messages out, and we have determined =
it does so when scanning the secondary side of the bridge, so we're =
suspecting our bridge node in the device tree is not correct.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C854D9.81C15FC7--
