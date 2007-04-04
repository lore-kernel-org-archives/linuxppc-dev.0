Return-Path: <akhilesh@innomedia.soft.net>
Received: from gateway.innomedia.soft.net (mail.innomedia.soft.net
	[164.164.79.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1494EDDF85
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 16:31:35 +1000 (EST)
Received: from innomedia ([192.168.18.10]) (authenticated bits=0)
	by gateway.innomedia.soft.net (8.13.1/8.13.1) with ESMTP id
	l346IH2M017818
	for <linuxppc-embedded@ozlabs.org>; Wed, 4 Apr 2007 11:48:17 +0530
Message-ID: <004d01c77681$3bdbae60$0a12a8c0@innomedia>
From: "Akhilesh Soni" <akhilesh@innomedia.soft.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Advice on Linux Framebuffer driver implemetation
Date: Wed, 4 Apr 2007 11:49:42 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_004A_01C776AF.55513C10"
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

------=_NextPart_000_004A_01C776AF.55513C10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I want advice on how to proceed for the following problem=20

As per my knowledge the Linux frame buffer requires the pixel data to be in=
 a packed pixel contiguous buffer. This means that the all the data for one=
 pixel must be packed together, followed by the data for the next pixel, et=
c.(please correct me if I'm wrong)

 On my Set-top-box hardware Vulcan (IBM ppc405),  the best resolution suppo=
rted  in this packed pixel format is 8bpp color table format. Vulcan resolu=
tions above the 8bpp color table resolution  require separate  luma and chr=
oma buffers,  where the hardware expects all the luma values to be in one b=
uffer and all chroma values to be in another buffer. Since the data for the=
 resolutions above 8bpp are required by the hardware to be in separate luma=
 and chroma buffers it does not meet the LInux Frame buffer requirement of =
packed pixel data.=20

Now how can I overcome this limitation where graphics H/W expects separate =
Luma and Chroma buffers whereas linux framebuffer expect all things packed.=
 Is there any such driver already present which I can study to overcome suc=
h limitation.

I'm using Montavista linux kernel 2.4.20 on IBM stb0x25xxx(ppc405 core).

Regards,
Akhilesh=20


--=20
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


------=_NextPart_000_004A_01C776AF.55513C10
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I want advice on how to proceed for the fo=
llowing=20
problem </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>As per my knowledge the <B>Linux frame buf=
fer</B>=20
requires the pixel data to be in a packed pixel <B>contiguous buffer</B>. T=
his=20
means that the all the data for one pixel must be packed together, followed=
 by=20
the data for the next pixel, etc.(please correct me if I'm wrong)</FONT></D=
IV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;On my&nbsp;Set-top-box hardware&nbsp=
;Vulcan=20
(IBM ppc405), &nbsp;the best resolution&nbsp;supported &nbsp;in this packed=
=20
pixel format is 8bpp color table format. Vulcan resolutions above the 8bpp =
color=20
table resolution &nbsp;require separate &nbsp;luma and chroma buffers,=20
&nbsp;where the hardware expects all the luma values to be in one buffer an=
d all=20
chroma values to be in another buffer. Since the data for the resolutions a=
bove=20
8bpp are required by the hardware to be in separate luma and chroma buffers=
 it=20
does not meet the LInux Frame buffer requirement of packed pixel data.=20
<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Now how can I overcome this limitation whe=
re=20
graphics H/W expects separate Luma and Chroma buffers whereas linux framebu=
ffer=20
expect all things packed. Is there any such driver already present which I =
can=20
study to overcome such limitation.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using Montavista linux kernel 2.4.20 o=
n IBM=20
stb0x25xxx(ppc405 core).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Akhilesh</FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT></BODY><br />--=20
<br />This message has been scanned for viruses and
<br />dangerous content by
<b>MailScanner</b>, and is
<br />believed to be clean.
</HTML>

------=_NextPart_000_004A_01C776AF.55513C10--
