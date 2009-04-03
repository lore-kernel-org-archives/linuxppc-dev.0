Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7ACC0DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 02:00:23 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n33F0IvQ018789
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 08:00:19 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n33F0GVf011274
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 10:00:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B46C.E5D6E4E9"
Subject: Re: Interrupt ID number on mpc8347
Date: Fri, 3 Apr 2009 23:00:16 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089136E78@zch01exm21.fsl.freescale.net>
References: <20090403163928.4679.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
	<1238756279.9595.15.camel@localhost>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: <michael@ellerman.id.au>,
	"yamazaki seiji" <yamazaki.seiji@kk.jp.panasonic.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B46C.E5D6E4E9
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> It's because the irqs are remapped by the kernel, the number in the
> device tree is a hardware irq number. The number you're printing out =
is
> a virtual irq number.

> of_irq_to_resource() is doing the remapping for you.

> You can turn on CONFIG_VIRQ_DEBUG and you'll get a file in debugfs =
that
> shows the mapping between hardware numbers and virtual numbers.

Guys,

I notice many people happened same issue to use the interrupt in powerpc
with DTS.
Could somebody write one documentation for interrupt system on powerpc =
arch,
 - how to remap irq
 - what is the virq? h/w irq.
 - show the mapping virt->h/w..
etc..
I think if have this docs, it will be helpful.

Thanks, Dave


------_=_NextPart_001_01C9B46C.E5D6E4E9
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: Interrupt ID number on mpc8347</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; It's because the irqs are remapped by the kernel, =
the number in the<BR>
&gt; device tree is a hardware irq number. The number you're printing =
out is<BR>
&gt; a virtual irq number.<BR>
<BR>
&gt; of_irq_to_resource() is doing the remapping for you.<BR>
<BR>
&gt; You can turn on CONFIG_VIRQ_DEBUG and you'll get a file in debugfs =
that<BR>
&gt; shows the mapping between hardware numbers and virtual numbers.<BR>
<BR>
Guys,<BR>
<BR>
I notice many people happened same issue to use the interrupt in =
powerpc<BR>
with DTS.<BR>
Could somebody write one documentation for interrupt system on powerpc =
arch,<BR>
&nbsp;- how to remap irq<BR>
&nbsp;- what is the virq? h/w irq.<BR>
&nbsp;- show the mapping virt-&gt;h/w..<BR>
etc..<BR>
I think if have this docs, it will be helpful.<BR>
<BR>
Thanks, Dave<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9B46C.E5D6E4E9--
