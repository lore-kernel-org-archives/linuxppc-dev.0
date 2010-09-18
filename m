Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id C32D6B70D0
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 03:36:13 +1000 (EST)
Received: from mail159-va3 (localhost.localdomain [127.0.0.1])	by
	mail159-va3-R.bigfish.com (Postfix) with ESMTP id 7768D680086	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 17:36:09 +0000 (UTC)
Received: from VA3EHSMHS006.bigfish.com (unknown [10.7.14.245])	by
	mail159-va3.bigfish.com (Postfix) with ESMTP id C054F8E004C	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 17:36:08 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8IHa8Vk028680	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 10:36:08 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8IHpQ2Z001606	for <linuxppc-dev@ozlabs.org>;
	Sat, 18 Sep 2010 12:51:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB5757.F8FE0438"
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
Date: Sat, 18 Sep 2010 10:36:05 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
In-Reply-To: <AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>	<1284779678.30449.108.camel@pasglop>	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------_=_NextPart_001_01CB5757.F8FE0438
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Josh Boyer wrote:
> It is not, in my opinion, about what is technically possible and what
> isn't.  The kernel is licensed under the GPL.  This is a Linux kernel
> only symbol.  One would be hard pressed to claim they have a driver
> that wasn't written for Linux that happens to need that symbol.  As a
> member of the Linux kernel community, I find it important to encourage
> the contribution of code back to the kernel, and this is one way to
> help that.  This isn't BSD.

Fine, but this goes back to my original question -- if this is how the=20
community feels, then why hasn't someone posted a patch that converts =
all=20
EXPORT_SYMBOL into EXPORT_SYMBOL_GPL?

Either we allow non-GPL drivers, or we don't.  If we don't, then we need =
to=20
eliminate EXPORT_SYMBOL once and for all.  Otherwise, the message is=20
hypocritical.


--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB5757.F8FE0438
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7655.10">
<TITLE>Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can =
reference it</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Josh Boyer wrote:<BR>
&gt; It is not, in my opinion, about what is technically possible and =
what<BR>
&gt; isn't.&nbsp; The kernel is licensed under the GPL.&nbsp; This is a =
Linux kernel<BR>
&gt; only symbol.&nbsp; One would be hard pressed to claim they have a =
driver<BR>
&gt; that wasn't written for Linux that happens to need that =
symbol.&nbsp; As a<BR>
&gt; member of the Linux kernel community, I find it important to =
encourage<BR>
&gt; the contribution of code back to the kernel, and this is one way =
to<BR>
&gt; help that.&nbsp; This isn't BSD.<BR>
<BR>
Fine, but this goes back to my original question -- if this is how =
the<BR>
community feels, then why hasn't someone posted a patch that converts =
all<BR>
EXPORT_SYMBOL into EXPORT_SYMBOL_GPL?<BR>
<BR>
Either we allow non-GPL drivers, or we don't.&nbsp; If we don't, then we =
need to<BR>
eliminate EXPORT_SYMBOL once and for all.&nbsp; Otherwise, the message =
is<BR>
hypocritical.<BR>
<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB5757.F8FE0438--
