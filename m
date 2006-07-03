Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF239679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 16:43:04 +1000 (EST)
Received: from CA1EXBH01.adcorp.kla-tencor.com
	(ca1exbh01.adcorp.kla-tencor.com [10.60.33.3])
	by ca1mail04.kla-tencor.com (8.12.10/8.12.11) with ESMTP id
	k635fE3a021419
	for <linuxppc-embedded@ozlabs.org>; Sun, 2 Jul 2006 22:41:16 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69E63.4C2402C1"
Subject: How do you set up a PPC440GX with a PHY on emac2 only?
Date: Sun, 2 Jul 2006 22:41:14 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE386FD3@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
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

------_=_NextPart_001_01C69E63.4C2402C1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Does anyone have any pointers/tips on how to set up a ocotea-like =
PPC440GX design with only a single gigabit (Cicada) PHY on emac2?  =
Editing ocotea_set_emacdata() to just define a single PHY doesn't work =
correctly.  It looks like this has something to do with the MII =
communtications being on the ZMII bridge on emac0 but defining emac0 =
doesn't help either.=20

Thanks,

Marc W. Howard

------_=_NextPart_001_01C69E63.4C2402C1
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
<TITLE>How do you set up a PPC440GX with a PHY on emac2 only?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
Does anyone have any pointers/tips on how to set up a ocotea-like =
PPC440GX design with only a single gigabit (Cicada) PHY on emac2?&nbsp; =
Editing ocotea_set_emacdata() to just define a single PHY doesn't work =
correctly.&nbsp; It looks like this has something to do with the MII =
communtications being on the ZMII bridge on emac0 but defining emac0 =
doesn't help either.<BR>
<BR>
Thanks,<BR>
<BR>
Marc W. Howard<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C69E63.4C2402C1--
