Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A652DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:13:35 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lA8KD0he002622
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 13:13:29 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA8KCwNc015643
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 14:12:59 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82243.C181630D"
Subject: RE: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
Date: Thu, 8 Nov 2007 13:10:13 -0700
Message-ID: <DDEDA444F5BF0E41AC8649FB40392C2902DA36@az33exm23.fsl.freescale.net>
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
	<F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
From: "Wang Haiying" <Haiying.Wang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Phillips Kim" <Kim.Phillips@freescale.com>
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

------_=_NextPart_001_01C82243.C181630D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, 8568mds dts should be updated. And I tested this ds1374 driver on =
8568mds board a couple of months ago, it worked fine. Code to parse =
device tree should be in fsl_soc.c.
=20
Haiying

________________________________

From: linuxppc-dev-bounces+haiying.wang=3Dfreescale.com@ozlabs.org on =
behalf of Kumar Gala
Sent: Thu 11/8/2007 12:57 PM
To: Phillips Kim
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes




On Nov 8, 2007, at 1:37 PM, Kim Phillips wrote:

> Now the rtc class ds1374 driver has been added,
> remove the old rtc driver hookup code, add rtc node
> to device trees, and turn on the new driver in the defconfigs.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts      |    7 ++++
>  arch/powerpc/boot/dts/mpc834x_mds.dts      |    9 +++++
>  arch/powerpc/boot/dts/mpc836x_mds.dts      |    9 +++++
>  arch/powerpc/configs/mpc832x_mds_defconfig |   48 +++++++++++++++++
> ++++++++++-
>  arch/powerpc/configs/mpc834x_mds_defconfig |   48 +++++++++++++++++
> ++++++++++-
>  arch/powerpc/configs/mpc836x_mds_defconfig |   48 +++++++++++++++++
> ++++++++++-
>  arch/powerpc/configs/mpc8568mds_defconfig  |   48 +++++++++++++++++
> ++++++++++-
>  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   24 --------------
>  arch/powerpc/platforms/83xx/mpc836x_mds.c  |   24 --------------
>  10 files changed, 213 insertions(+), 76 deletions(-)

should the mpc8568mds.dts be updated?

Also, what code is parsing the device tree for the rtc node?

- k


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C82243.C181630D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH] powerpc: mpc8xxx MDS board RTC =
fixes</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3199" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText25455 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Yes, 8568mds =
dts should be updated. And I tested this ds1374 driver on 8568mds =
board&nbsp;a couple of months ago, it worked fine. Code to parse device =
tree should be in fsl_soc.c.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Haiying</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =
linuxppc-dev-bounces+haiying.wang=3Dfreescale.com@ozlabs.org on behalf =
of Kumar Gala<BR><B>Sent:</B> Thu 11/8/2007 12:57 PM<BR><B>To:</B> =
Phillips Kim<BR><B>Cc:</B> linuxppc-dev@ozlabs.org<BR><B>Subject:</B> =
Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes<BR></FONT><BR></DIV>=0A=
<DIV><BR>=0A=
<P><FONT size=3D2>On Nov 8, 2007, at 1:37 PM, Kim Phillips =
wrote:<BR><BR>&gt; Now the rtc class ds1374 driver has been =
added,<BR>&gt; remove the old rtc driver hookup code, add rtc =
node<BR>&gt; to device trees, and turn on the new driver in the =
defconfigs.<BR>&gt;<BR>&gt; Signed-off-by: Kim Phillips =
&lt;kim.phillips@freescale.com&gt;<BR>&gt; ---<BR>&gt;&nbsp; =
arch/powerpc/boot/dts/mpc832x_mds.dts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp; 7 ++++<BR>&gt;&nbsp; =
arch/powerpc/boot/dts/mpc834x_mds.dts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp; 9 +++++<BR>&gt;&nbsp; =
arch/powerpc/boot/dts/mpc836x_mds.dts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp; 9 +++++<BR>&gt;&nbsp; =
arch/powerpc/configs/mpc832x_mds_defconfig |&nbsp;&nbsp; 48 =
+++++++++++++++++<BR>&gt; ++++++++++-<BR>&gt;&nbsp; =
arch/powerpc/configs/mpc834x_mds_defconfig |&nbsp;&nbsp; 48 =
+++++++++++++++++<BR>&gt; ++++++++++-<BR>&gt;&nbsp; =
arch/powerpc/configs/mpc836x_mds_defconfig |&nbsp;&nbsp; 48 =
+++++++++++++++++<BR>&gt; ++++++++++-<BR>&gt;&nbsp; =
arch/powerpc/configs/mpc8568mds_defconfig&nbsp; |&nbsp;&nbsp; 48 =
+++++++++++++++++<BR>&gt; ++++++++++-<BR>&gt;&nbsp; =
arch/powerpc/platforms/83xx/mpc832x_mds.c&nbsp; |&nbsp;&nbsp; 24 =
--------------<BR>&gt;&nbsp; =
arch/powerpc/platforms/83xx/mpc834x_mds.c&nbsp; |&nbsp;&nbsp; 24 =
--------------<BR>&gt;&nbsp; =
arch/powerpc/platforms/83xx/mpc836x_mds.c&nbsp; |&nbsp;&nbsp; 24 =
--------------<BR>&gt;&nbsp; 10 files changed, 213 insertions(+), 76 =
deletions(-)<BR><BR>should the mpc8568mds.dts be updated?<BR><BR>Also, =
what code is parsing the device tree for the rtc node?<BR><BR>- =
k<BR><BR><BR>_______________________________________________<BR>Linuxppc-=
dev mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A =
href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C82243.C181630D--
