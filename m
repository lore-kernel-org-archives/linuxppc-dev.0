Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.alcatel-sbell.com.cn (unknown [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 70603B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 14:59:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA9A4D.F604BAFA"
Subject: RE: How to trun off udbg0 during bootup?
Date: Thu, 21 Jan 2010 11:56:48 +0800
Message-ID: <6A5F574C5A990242B0541891CF955C0D01D1EDBD@CNSHGSMBS05.ad4.ad.alcatel.com>
References: <b90a809a1001201702y7d42eb60v43f24cb1043a89fa@mail.gmail.com>
From: "SHAN Gavin" <Gavin.Shan@alcatel-lucent.com>
To: "???" <wenlinjing@gmail.com>,
	<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA9A4D.F604BAFA
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


=20
Hi,

 I `m working on a freescale-MPC8379eRDB like board.And I want to trun =
off
kernel message during bootup.

 I tried to  modify "console =3D XXX" argument in uboot but it did not =
work(It
works on ARM). Kernel always print:

"console [udbg0] enabled"    or   "console handover: boot [*udbg0*] -> =
real
[ttyS1]"

Does anybody know how can I turn off this udbg0?

You may check arch/powerpc/kernel/udbg.c and disable registering the =
early
debug console driver. Then you can not see the output before the message
line like "-> real [ttyS1]"

Good luck,
Gavin


------_=_NextPart_001_01CA9A4D.F604BAFA
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: How to trun off udbg0 during bootup?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2><BR>
Hi,<BR>
<BR>
&nbsp;I `m working on a freescale-MPC8379eRDB like board.And I want to =
trun off<BR>
kernel message during bootup.<BR>
<BR>
&nbsp;I tried to&nbsp; modify &quot;console =3D XXX&quot; argument in =
uboot but it did not work(It<BR>
works on ARM). Kernel always print:<BR>
<BR>
&quot;console [udbg0] enabled&quot;&nbsp;&nbsp;&nbsp; or&nbsp;&nbsp; =
&quot;console handover: boot [*udbg0*] -&gt; real<BR>
[ttyS1]&quot;<BR>
<BR>
Does anybody know how can I turn off this udbg0?<BR>
<BR>
You may check arch/powerpc/kernel/udbg.c and disable registering the =
early<BR>
debug console driver. Then you can not see the output before the =
message<BR>
line like &quot;-&gt; real [ttyS1]&quot;<BR>
<BR>
Good luck,<BR>
Gavin<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA9A4D.F604BAFA--
