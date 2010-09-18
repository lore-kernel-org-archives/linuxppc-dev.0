Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 609A6B70D1
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 04:10:44 +1000 (EST)
Received: from mail20-db3 (localhost.localdomain [127.0.0.1])	by
	mail20-db3-R.bigfish.com (Postfix) with ESMTP id 650B61168374	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 18:04:59 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.246])	by
	mail20-db3.bigfish.com (Postfix) with ESMTP id BD58B37004B	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 18:04:58 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8IHtTYu025282	for
	<linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 10:55:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8II9md2024276	for <linuxppc-dev@ozlabs.org>;
	Sat, 18 Sep 2010 13:09:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB575A.ADFFAA56"
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
Date: Sat, 18 Sep 2010 10:55:28 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A75073034792F9@az33exm25.fsl.freescale.net>
In-Reply-To: <AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>	<1284779678.30449.108.camel@pasglop>	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>	<5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
	<AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
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

------_=_NextPart_001_01CB575A.ADFFAA56
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Josh Boyer wrote:
> This is a new symbol being exported, not
> one that has been exported for years.

Except that Ben says that I should change ppc_proc_freq from =
EXPORT_SYMBOL to=20
EXPORT_SYMBOL_GPL as well.  In a sense, we're in a catch-22.  We have =
three=20
choices:

1. We *arbitrarily* change ppc_proc_freq from EXPORT_SYMBOL to=20
EXPORT_SYMBOL_GPL, so that the two symbols are exported the same way

2. We GPL-export only ppc_tb_freq and leave ppc_proc_freq as-is, but =
then it=20
looks dumb.

3. We export ppc_tb_freq the same way we're exporting ppc_proc_freq,=20
providing the most options and maintaining consistency.

I just don't see how options #1 or #2 are better than #3, and so far the =
only=20
explanations I've heard are along the lines of "we just like it that =
way".

Obviously, Linus thinks it's okay to allow some non-GPL modules, =
otherwise he=20
would have long ago changed all EXPORT_SYMBOLs to EXPORT_SYMBOL_GPL.  =
I'm=20
just capitalizing on that mindset.

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB575A.ADFFAA56
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
&gt; This is a new symbol being exported, not<BR>
&gt; one that has been exported for years.<BR>
<BR>
Except that Ben says that I should change ppc_proc_freq from =
EXPORT_SYMBOL to<BR>
EXPORT_SYMBOL_GPL as well.&nbsp; In a sense, we're in a catch-22.&nbsp; =
We have three<BR>
choices:<BR>
<BR>
1. We *arbitrarily* change ppc_proc_freq from EXPORT_SYMBOL to<BR>
EXPORT_SYMBOL_GPL, so that the two symbols are exported the same way<BR>
<BR>
2. We GPL-export only ppc_tb_freq and leave ppc_proc_freq as-is, but =
then it<BR>
looks dumb.<BR>
<BR>
3. We export ppc_tb_freq the same way we're exporting ppc_proc_freq,<BR>
providing the most options and maintaining consistency.<BR>
<BR>
I just don't see how options #1 or #2 are better than #3, and so far the =
only<BR>
explanations I've heard are along the lines of &quot;we just like it =
that way&quot;.<BR>
<BR>
Obviously, Linus thinks it's okay to allow some non-GPL modules, =
otherwise he<BR>
would have long ago changed all EXPORT_SYMBOLs to =
EXPORT_SYMBOL_GPL.&nbsp; I'm<BR>
just capitalizing on that mindset.<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB575A.ADFFAA56--
