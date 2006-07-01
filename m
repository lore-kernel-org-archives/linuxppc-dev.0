Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4349C67A62
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 14:15:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69CC5.075BD621"
Subject: RE: [PATCH] powerpc:Fix rheap alignment problem
Date: Fri, 30 Jun 2006 23:13:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	<1151709194.27137.2.camel@localhost.localdomain>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69CC5.075BD621
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Benjamin Herrenschmidt
>What is this used for ? This rheap allocator ?

It is used for allocating dual port RAM on 8xx and 82xx. (and probably =
others that have a CPM)
Most/all usage is still in ppc.

------_=_NextPart_001_01C69CC5.075BD621
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>RE: [PATCH] powerpc:Fix rheap alignment problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: Benjamin Herrenschmidt<BR>
&gt;What is this used for ? This rheap allocator ?<BR>
<BR>
It is used for allocating dual port RAM on 8xx and 82xx. (and probably =
others that have a CPM)<BR>
Most/all usage is still in ppc.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C69CC5.075BD621--
