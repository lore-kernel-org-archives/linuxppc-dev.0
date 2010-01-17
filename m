Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.alcatel-sbell.com.cn (unknown [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id B4792B7CE6
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jan 2010 18:39:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA9748.06770A54"
Subject: RE: openpic specification
Date: Sun, 17 Jan 2010 15:38:13 +0800
Message-ID: <6A5F574C5A990242B0541891CF955C0D01D1ED99@CNSHGSMBS05.ad4.ad.alcatel.com>
References: <4B518E4B.4010202@alcatel-lucent.com>
	<451D99C3-3C43-450E-A1F5-C828A5EA4BFA@kernel.crashing.org>
From: "SHAN Gavin" <Gavin.Shan@alcatel-lucent.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA9748.06770A54
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable



> I ever searched openpic specification on google for several times, but =
unfortunately nothing found.
> Could anybody point me where I can get the openpic specification?
>=20
> The source code seems being from IBM: arch/powerpc/sysdev/mpic.c

While not the openpic spec if you grab any of the Freescale RM for =
MPC85xx chips there will be a chapter on the PIC that is an "openPIC" =
based interrupt controller.

Thanks, Kumar. Actually, I'm facing a wired issue on my system: some =
times, the interrupt
from external devices can't be seen from CPU. That means the CPU was =
never disturbed by
extern interrupts at some point. I don't know why, it seems the PIC just =
ignored the
external interrupts.

We're using Pasemi 1682M part, which integrated a openpic compatible =
PIC. But the CPU part has 2
cores. There're 3 kinds of interrupts:

several internal interrupts - priority 8
one external interrupt      - priority 8
IPI                         - priority 10

Thanks,
Gavin


------_=_NextPart_001_01CA9748.06770A54
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
<TITLE>RE: openpic specification</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>

<P><FONT SIZE=3D2>&gt; I ever searched openpic specification on google =
for several times, but unfortunately nothing found.<BR>
&gt; Could anybody point me where I can get the openpic =
specification?<BR>
&gt;<BR>
&gt; The source code seems being from IBM: =
arch/powerpc/sysdev/mpic.c<BR>
<BR>
While not the openpic spec if you grab any of the Freescale RM for =
MPC85xx chips there will be a chapter on the PIC that is an =
&quot;openPIC&quot; based interrupt controller.<BR>
<BR>
Thanks, Kumar. Actually, I'm facing a wired issue on my system: some =
times, the interrupt<BR>
from external devices can't be seen from CPU. That means the CPU was =
never disturbed by<BR>
extern interrupts at some point. I don't know why, it seems the PIC just =
ignored the<BR>
external interrupts.<BR>
<BR>
We're using Pasemi 1682M part, which integrated a openpic compatible =
PIC. But the CPU part has 2<BR>
cores. There're 3 kinds of interrupts:<BR>
<BR>
several internal interrupts - priority 8<BR>
one external interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - priority 8<BR>
IPI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; - priority 10<BR>
<BR>
Thanks,<BR>
Gavin<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA9748.06770A54--
