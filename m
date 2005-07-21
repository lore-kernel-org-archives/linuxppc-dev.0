Return-Path: <nhennenfent@egtinc.com>
Received: from mail.egtinc.com (vpn.egtinc.com [65.182.45.194])
	by ozlabs.org (Postfix) with ESMTP id 4117167CA2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 22:56:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C58DF1.F9DD2720"
Date: Thu, 21 Jul 2005 08:44:46 -0400
Message-ID: <A3008858EC44C34382A7E3935C24615E01074D3B@egtf001.egt.intra>
From: "Nick Hennenfent" <nhennenfent@egtinc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: I need help with L2 cache on 440GX rev C
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

------_=_NextPart_001_01C58DF1.F9DD2720
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


I have an embedded 440GX rev C runnng at about 500Mhz.
I am using a 2.4.20 linux kernel.
I borrowed Matt Porter's code from the 2.6 kernels in
order to enable the L2 cache. The code compiles and
runs ok, but the cache does not seem to be enabled!!!
I ran some tests with/without the L2 cache code and=20
there is no difference.
(A qsort of 1 million random integers takes 2 seconds).
Is there some other magic trick to enable that cache????
Any help is much appreciated.
Thanks,
Nick Hennenfent




------_=_NextPart_001_01C58DF1.F9DD2720
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6487.1">
<TITLE>I need help with L2 cache on 440GX rev C</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I have an embedded 440GX rev C runnng at about =
500Mhz.<BR>
I am using a 2.4.20 linux kernel.<BR>
I borrowed Matt Porter's code from the 2.6 kernels in<BR>
order to enable the L2 cache. The code compiles and<BR>
runs ok, but the cache does not seem to be enabled!!!<BR>
I ran some tests with/without the L2 cache code and<BR>
there is no difference.<BR>
(A qsort of 1 million random integers takes 2 seconds).<BR>
Is there some other magic trick to enable that cache????<BR>
Any help is much appreciated.<BR>
Thanks,<BR>
Nick Hennenfent<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C58DF1.F9DD2720--
