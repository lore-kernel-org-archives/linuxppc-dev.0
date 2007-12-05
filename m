Return-Path: <CFester@iphase.com>
Received: from exmail.interphase.iphase.com (h126.iphase.com [157.175.3.126])
	by ozlabs.org (Postfix) with ESMTP id C2571DDE9B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 04:21:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83761.9760D900"
Subject: Re: Regarding MPC8641D
Date: Wed, 5 Dec 2007 11:06:56 -0600
Message-ID: <1196874416.32356.3.camel@kaboom.lisle.iphase.com>
In-Reply-To: <14166848.post@talk.nabble.com>
References: <14166848.post@talk.nabble.com>
From: "Christopher Fester" <CFester@iphase.com>
To: "sivaji" <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Christopher Fester <cfester@iphase.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83761.9760D900
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:
>             We have designed  a MPC8641D based AMC card. We are using =
the
> kernel (2.6.23-rc4) and uboot (1.2.0).  When we disable the core1 Low =
Memory
> offset mode the kernel was up and when we enable this core1 Low Memory
> offset mode kernel was not up, It was hang after MPIC initialization.
[snip!]
>                      After this the kernel was hang, i want to know =
why
> kernel was hang when we enalbe Low memory Offset mode. Please help me =
to fix
> this issue.

Have you compiled your kernel for SMP mode?  I believe the Low memory
offset mode is only for AMP mode (vxworks can use this, probably other
OSes).  I don't know if the kernel has support for any multiprocessing
mode other than SMP.

Hope that helps,
Chris

------_=_NextPart_001_01C83761.9760D900
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
<TITLE>Re: Regarding MPC8641D</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>On Tue, 2007-12-04 at 23:51 -0800, sivaji wrote:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; We have designed&nbsp; a MPC8641D based AMC card. We are using =
the<BR>
&gt; kernel (2.6.23-rc4) and uboot (1.2.0).&nbsp; When we disable the =
core1 Low Memory<BR>
&gt; offset mode the kernel was up and when we enable this core1 Low =
Memory<BR>
&gt; offset mode kernel was not up, It was hang after MPIC =
initialization.<BR>
[snip!]<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; After this the =
kernel was hang, i want to know why<BR>
&gt; kernel was hang when we enalbe Low memory Offset mode. Please help =
me to fix<BR>
&gt; this issue.<BR>
<BR>
Have you compiled your kernel for SMP mode?&nbsp; I believe the Low =
memory<BR>
offset mode is only for AMP mode (vxworks can use this, probably =
other<BR>
OSes).&nbsp; I don't know if the kernel has support for any =
multiprocessing<BR>
mode other than SMP.<BR>
<BR>
Hope that helps,<BR>
Chris<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C83761.9760D900--
