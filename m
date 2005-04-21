Return-Path: <Bjorn.Ostby@combitechsystems.com>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 5BDDB67A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 20:24:50 +1000 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-101.aerotechtelub.se (Clearswift SMTPRS 5.0.9) with ESMTP id
	<T70711706b9c0b021a1c4c@ms-101.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Thu, 21 Apr 2005 12:14:31 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5465A.18D4BF87"
Date: Thu, 21 Apr 2005 12:08:42 +0200
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC05@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Preemption patch problem
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

------_=_NextPart_001_01C5465A.18D4BF87
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Greetings.

I have been struggling with the famous preemption patch (from Robert =
Love) the past few days. Im using mpc823e=20
and tried with kernels 2.4.{18,21,22,23}. The patch applies flawless and =
so on, but when the kernel is up and running
strange memory problems start to appear like:

_alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)

Right, so... It seems like a giant memory leak of some sort, cause when =
I run programs the kernel goes ballistic and
starts reaping processes:

"VM: Killing process <name>"

Eventually it comes down to "VM: killing init" and then it's curtains.

I know that these problems is caused by the patch since the kernel runs =
smooth without the patch applied.
Does anyone have a clue what to do here (beside let go of the patch)?=20


Best regards,
Bj=F6rn=20
-----------------------------------------
"failure is not an option"





------_=_NextPart_001_01C5465A.18D4BF87
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>Preemption patch problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 =
FACE=3D"Arial">Greetings.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I have been =
struggling with the famous preemption patch (from Robert Love) the past =
few days. Im using mpc823e </FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">and tried with =
kernels 2.4.{18,21,22,23}. The patch applies flawless and so on, but =
when the kernel is up and running</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">strange memory =
problems start to appear like:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">_alloc_pages: 0-order =
allocation failed (gfp=3D0x1d2/0)</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Right, so&#8230; It =
seems like a giant memory leak of some sort, cause when I run programs =
the kernel goes ballistic and</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">starts reaping =
processes:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">&quot;VM: Killing =
process &lt;name&gt;&quot;</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Eventually it comes =
down to &quot;VM: killing init&quot; and then it's =
curtains.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">I know that these =
problems is caused by the patch since the kernel runs smooth without the =
patch applied.</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Does anyone have a =
clue what to do here (beside let go of the patch)? </FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Best =
regards,</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">Bj=F6rn =
</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 =
FACE=3D"Arial">-----------------------------------------</FONT></SPAN>

<BR><SPAN LANG=3D"sv"><FONT SIZE=3D2 FACE=3D"Arial">&quot;failure is not =
an option&quot;</FONT></SPAN>
</P>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C5465A.18D4BF87--
