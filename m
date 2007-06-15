Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DB905DDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 13:49:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7AF00.2EAF5E0C"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 22:47:20 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B07B41E@ismail.innsys.innovsys.com>
References: <989B956029373F45A0B8AF0297081890D2AE6C@zch01exm26.fsl.freescale.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	<joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7AF00.2EAF5E0C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>From: Li Yang-r58472 [mailto:LeoLi@freescale.com]
>>  	if (assure_empty(info, 1) < 0)
>>  		return ERR_PTR(-ENOMEM);

>You also need to change this to assure_empty(info, 2), as you are very
>likely to need 2 slots afterward.  You need to assure there are enough
>slots or grow the block number.

Ahh. I'll fix that in my code.
It was a quick&dirty hack to get the allocator to work wen we used most =
of the available DPRAM.

------_=_NextPart_001_01C7AF00.2EAF5E0C
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
<TITLE>RE: ucc_geth DPRAM alloc error, 2.6.22-rc3</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt;From: Li Yang-r58472 [<A =
HREF=3D"mailto:LeoLi@freescale.com">mailto:LeoLi@freescale.com</A>]<BR>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; if (assure_empty(info, 1) &lt; 0)<BR>
&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-ENOMEM);<BR>
<BR>
&gt;You also need to change this to assure_empty(info, 2), as you are =
very<BR>
&gt;likely to need 2 slots afterward.&nbsp; You need to assure there are =
enough<BR>
&gt;slots or grow the block number.<BR>
<BR>
Ahh. I'll fix that in my code.<BR>
It was a quick&amp;dirty hack to get the allocator to work wen we used =
most of the available DPRAM.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7AF00.2EAF5E0C--
