Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail186-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2F927DDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 16:55:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82E5E.9EF8AB20"
Subject: RE: Xilinx Linux git server available
Date: Fri, 23 Nov 2007 21:54:33 -0800
References: <20071114015615.12B9B1528050@mail173-sin.bigfish.com><8763zufl29.fsf@macbook.be.48ers.dk><fa686aa40711220635g1aa7dcc9w823de6a8c2d5832a@mail.gmail.com><871waifgbf.fsf@macbook.be.48ers.dk><fa686aa40711220739i3e950a59w5becd19125c23ff1@mail.gmail.com>
	<87wssae11t.fsf@macbook.be.48ers.dk>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071124055535.81DD75F806D@mail186-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82E5E.9EF8AB20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


It was the edk-derived driver for the uartlite..  The functionality is =
now provided by the open source driver.

Steve

-----Original Message-----
From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org =
on behalf of Peter Korsgaard
Sent: Thu 11/22/2007 7:45 AM
To: Grant Likely
Cc: linuxppc-dev@ozlabs.org; Wolfgang Reissnegger
Subject: Re: Xilinx Linux git server available
=20
>>>>> "Grant" =3D=3D Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 >> Ok, I had a quick look at the tree and saw a uartlite-alternative.c =
-
 >> What's that about?

 Grant> What directory is that in?  I had looked in drivers/serial and =
only
 Grant> saw uartlite.c:

It's gone now (I accidently ended up browsing an earlier version
before):

http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=3Dcommi=
t;h=3D9912d5bf98f969324e1d4f12210adccd1530de68

--=20
Bye, Peter Korsgaard
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



------_=_NextPart_001_01C82E5E.9EF8AB20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Xilinx Linux git server available</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>It was the edk-derived driver for the uartlite..&nbsp; =
The functionality is now provided by the open source driver.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org =
on behalf of Peter Korsgaard<BR>
Sent: Thu 11/22/2007 7:45 AM<BR>
To: Grant Likely<BR>
Cc: linuxppc-dev@ozlabs.org; Wolfgang Reissnegger<BR>
Subject: Re: Xilinx Linux git server available<BR>
<BR>
&gt;&gt;&gt;&gt;&gt; &quot;Grant&quot; =3D=3D Grant Likely =
&lt;grant.likely@secretlab.ca&gt; writes:<BR>
<BR>
Hi,<BR>
<BR>
&nbsp;&gt;&gt; Ok, I had a quick look at the tree and saw a =
uartlite-alternative.c -<BR>
&nbsp;&gt;&gt; What's that about?<BR>
<BR>
&nbsp;Grant&gt; What directory is that in?&nbsp; I had looked in =
drivers/serial and only<BR>
&nbsp;Grant&gt; saw uartlite.c:<BR>
<BR>
It's gone now (I accidently ended up browsing an earlier version<BR>
before):<BR>
<BR>
<A =
HREF=3D"http://git.xilinx.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=
=3Dcommit;h=3D9912d5bf98f969324e1d4f12210adccd1530de68">http://git.xilinx=
.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-xlnx.git;a=3Dcommit;h=3D9912d5bf98f=
969324e1d4f12210adccd1530de68</A><BR>
<BR>
--<BR>
Bye, Peter Korsgaard<BR>
_______________________________________________<BR>
Linuxppc-dev mailing list<BR>
Linuxppc-dev@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.=
org/mailman/listinfo/linuxppc-dev</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82E5E.9EF8AB20--
