Return-Path: <Vivek.Mahajan@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FDF4B7B7A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 21:03:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8NB3r07023984
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:03:54 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8NB5ii3020932
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 06:05:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA3C3D.8883CB09"
Subject: 2.6.31: powerpc build errors with include/linux/perf_counter.h
Date: Wed, 23 Sep 2009 16:35:28 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08FF6167@zin33exm23.fsl.freescale.net>
From: "Mahajan Vivek-B08308" <Vivek.Mahajan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Cc: markus.t.metzger@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA3C3D.8883CB09
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello Markus,
=20
Apparently this
http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dcommitdi=
ff;
h=3D5622f295b53fb60dbf9bed3e2c89d182490a8b7f breaks the powerpc build as
under when built from
http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dsummary
with latest commit ebc79c4f8da0f92efa968e0328f32334a2ce80cf
=20
cc1: warnings being treated as errors
In file included from arch/powerpc/kernel/irq.c:56:
include/linux/perf_counter.h: In function 'perf_output_begin':
include/linux/perf_counter.h:854: warning: no return statement in
function returning non-void
include/linux/perf_counter.h: At top level:
include/linux/perf_counter.h:863: warning: 'struct perf_sample_data'
declared inside parameter list
include/linux/perf_counter.h:863: warning: its scope is only this
definition or declaration, which is probably not what
include/linux/perf_counter.h:868: warning: 'struct perf_sample_data'
declared inside parameter list
make[1]: *** [arch/powerpc/kernel/irq.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

Thanks,
Vivek

------_=_NextPart_001_01CA3C3D.8883CB09
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D796375310-23092009>Hello=20
Markus,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D796375310-23092009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D796375310-23092009>Apparently this <A=20
href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3D=
commitdiff;h=3D5622f295b53fb60dbf9bed3e2c89d182490a8b7f">http://git.kerne=
l.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dcommitdiff;h=3D5622f295b=
53fb60dbf9bed3e2c89d182490a8b7f</A>&nbsp;breaks=20
the powerpc build as under when built from <A=20
href=3D"http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3D=
summary">http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3D=
summary</A>&nbsp;with=20
latest commit&nbsp;<FONT face=3D"Times New Roman"=20
size=3D3>ebc79c4f8da0f92efa968e0328f32334a2ce80cf</FONT></SPAN></FONT></D=
IV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D796375310-23092009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D796375310-23092009>cc1: =
warnings being=20
treated as errors<BR>In file included from=20
arch/powerpc/kernel/irq.c:56:<BR>include/linux/perf_counter.h: In =
function=20
'perf_output_begin':<BR>include/linux/perf_counter.h:854: warning: no =
return=20
statement in function returning =
non-void<BR>include/linux/perf_counter.h: At top=20
level:<BR>include/linux/perf_counter.h:863: warning: 'struct =
perf_sample_data'=20
declared inside parameter list<BR>include/linux/perf_counter.h:863: =
warning: its=20
scope is only this definition or declaration, which is probably not=20
what<BR>include/linux/perf_counter.h:868: warning: 'struct =
perf_sample_data'=20
declared inside parameter list<BR>make[1]: *** =
[arch/powerpc/kernel/irq.o] Error=20
1<BR>make: *** [arch/powerpc/kernel] Error 2<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D796375310-23092009>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D796375310-23092009>Vivek</DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01CA3C3D.8883CB09--
