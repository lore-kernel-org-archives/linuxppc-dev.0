Return-Path: <tliang@Brocade.COM>
Received: from mail53.messagelabs.com (mail53.messagelabs.com [216.82.249.211])
	by ozlabs.org (Postfix) with SMTP id 2F52167BE3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 05:03:35 +1000 (EST)
Received: from hq-exch-1.corp.brocade.com (hq-exch-1.brocade.com [10.3.8.21])
	by scooby.brocade.com (Postfix) with ESMTP id F394225801B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 11:59:50 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C6E6.D3860D69"
Subject: atomic operations in user space
Date: Wed, 23 Aug 2006 12:03:32 -0700
Message-ID: <82557754AC6C0448A2218FD1C7D50E2AC6FE9F@hq-exch-1.corp.brocade.com>
From: "Terry Liang" <tliang@Brocade.COM>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6C6E6.D3860D69
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks. Arnd. My main concern is whether the operations are really =
atomic as they are in the kernel space. I have read some discussion in =
another forum that on other platforms, even if you are able to compile =
the atomic_add(), atomic_set(), etc. from an user space application,  =
they don't guarantee to be atomic. Thanks.

Regards,

Terry Liang

------_=_NextPart_001_01C6C6E6.D3860D69
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>atomic operations in user space</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks. Arnd. My main concern is =
whether the operations are really atomic as they are in the kernel =
space. I have read some discussion in another forum that on other =
platforms, even if you are able to compile the atomic_add(), =
atomic_set(), etc. from an user space application,&nbsp; they don't =
guarantee to be atomic. Thanks.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards,</FONT>
<BR>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Terry Liang</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6C6E6.D3860D69--
