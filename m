Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 0BBA6DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 09:24:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85A20.EFCE0116"
Subject: RE: A file of 5 MB on tmpfs file system uses 5 MB of RAM or more?
Date: Fri, 18 Jan 2008 23:23:20 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264A19@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC8BBD1@aquib01a>
	<20080118155853.GA15620@ld0162-tx32.am.freescale.net>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C85A20.EFCE0116
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

No I simply did several malloc(s) without writing to the allocated =
space.

This means that the pages are not allocated really?



-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]
Sent: Fri 18/01/2008 16.58
To: DI BACCO ANTONIO - technolabs
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A file of 5 MB on tmpfs file system uses 5 MB of RAM or =
more?
=20
On Fri, Jan 18, 2008 at 02:15:02PM +0100, DI BACCO ANTONIO - technolabs =
wrote:
> I have a linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 MB
> flash.=20
> Normally I have 9-10 MB of free RAM.
> =20
> If I allocate 5 MB of ram memory, the system continues to work =
normally,

Are you sure the RAM was actually allocated (i.e. did you write to all =
of
the pages)?

-Scott


------_=_NextPart_001_01C85A20.EFCE0116
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>RE: A file of 5 MB on tmpfs file system uses 5 MB of RAM or =
more?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>No I simply did several malloc(s) without writing to =
the allocated space.<BR>
<BR>
This means that the pages are not allocated really?<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Scott Wood [<A =
HREF=3D"mailto:scottwood@freescale.com">mailto:scottwood@freescale.com</A=
>]<BR>
Sent: Fri 18/01/2008 16.58<BR>
To: DI BACCO ANTONIO - technolabs<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: A file of 5 MB on tmpfs file system uses 5 MB of RAM or =
more?<BR>
<BR>
On Fri, Jan 18, 2008 at 02:15:02PM +0100, DI BACCO ANTONIO - technolabs =
wrote:<BR>
&gt; I have a linux-2.6.19.2 board with an MPC880 with 16MB ram and 16 =
MB<BR>
&gt; flash.<BR>
&gt; Normally I have 9-10 MB of free RAM.<BR>
&gt;&nbsp;<BR>
&gt; If I allocate 5 MB of ram memory, the system continues to work =
normally,<BR>
<BR>
Are you sure the RAM was actually allocated (i.e. did you write to all =
of<BR>
the pages)?<BR>
<BR>
-Scott<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C85A20.EFCE0116--
