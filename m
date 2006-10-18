Return-Path: <john.bonesio@xilinx.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD44667BD3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 02:01:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F2CA.55498F3A"
Subject: RE: Looking For XILINX TEMAC Driver For linux 2.4 or 2.6 
Date: Wed, 18 Oct 2006 08:30:25 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC0152EB@XSJ-EXCHVS1.xlnx.xilinx.com>
References: <8506C3905ED0764F889ADEB33E3A9E8062CECA@MAIA.scopus.net>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Sharon Feldman" <sharonf@scopus.net>, <linuxppc-embedded@ozlabs.org>
Cc: Rick Moleres <rick.moleres@xilinx.com>
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

------_=_NextPart_001_01C6F2CA.55498F3A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I could just send out one of these drivers and hope that it helps, but I =
thought it might be better to find out some more specifics on what is =
needed first. This way we can avoid lots thrashing and missed attempts =
at getting something to work.
=20
What TEMAC core are you using? What version?
Is there a preference of linux kernels, 2.4 or 2.6?
If you prefer 2.6, do you already have the other kernel changes to =
support Virtex 4 (assuming that's the fpga you're using)?
=20
Let me know what you're trying to accomplish so I can give you better =
specific help.
=20
- John

________________________________

From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org on =
behalf of Sharon Feldman
Sent: Wed 10/18/2006 8:01 AM
To: linuxppc-embedded@ozlabs.org
Subject: Looking For XILINX TEMAC Driver For linux 2.4 or 2.6=20



I Need XILINX ll_temac Or PLB_Temac Drivers For Linux 2.4 Or 2.6

I Understand There Is A Driver For MV That Can Be Used.

Best Regards/


------_=_NextPart_001_01C6F2CA.55498F3A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>Looking For XILINX TEMAC Driver For linux 2.4 or 2.6 </TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText2012 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Hi,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I could just =
send out one of =0A=
these drivers and hope that it helps, but I thought it might be better =
to find =0A=
out some more specifics on what is needed first. This way we can avoid =
lots =0A=
thrashing and missed attempts at getting something to work.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>What TEMAC core are you =
using? What =0A=
version?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Is there a preference of =
linux kernels, 2.4 =0A=
or 2.6?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>If you prefer 2.6, do you =
already have the =0A=
other kernel changes to support Virtex 4 (assuming that's the fpga =
you're =0A=
using)?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Let me know what you're =
trying to =0A=
accomplish so I can give you better specific help.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>- John</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> =0A=
linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org on behalf of =
Sharon =0A=
Feldman<BR><B>Sent:</B> Wed 10/18/2006 8:01 AM<BR><B>To:</B> =0A=
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Looking For XILINX TEMAC =
Driver =0A=
For linux 2.4 or 2.6 <BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P dir=3Dltr><FONT face=3DArial size=3D2>I Need XILINX ll_temac Or =
PLB_Temac Drivers =0A=
For Linux 2.4 Or 2.6</FONT></P>=0A=
<P dir=3Dltr><FONT face=3DArial size=3D2>I Understand There Is A Driver =
For MV That =0A=
Can Be Used.</FONT></P>=0A=
<P dir=3Dltr><FONT face=3DArial size=3D2>Best Regards/</FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C6F2CA.55498F3A--
