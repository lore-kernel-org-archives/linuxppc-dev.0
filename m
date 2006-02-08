Return-Path: <pauleaton@earthlink.net>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id ED92768A7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 07:25:31 +1100 (EST)
Received: from [24.181.178.78] (helo=paulsnotebook)
	by smtpauth07.mail.atl.earthlink.net with asmtp (Exim 4.34)
	id 1F6vkK-00056z-DT
	for linuxppc-embedded@ozlabs.org; Wed, 08 Feb 2006 15:17:00 -0500
Message-ID: <001301c62cec$9aa02b90$6701a8c0@paulsnotebook>
From: "Paul  Eaton" <pauleaton@earthlink.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8248 DPRAM linker script
Date: Wed, 8 Feb 2006 15:16:46 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0010_01C62CC2.ACC81870"
Reply-To: Paul  Eaton <pauleaton@earthlink.net>
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

------=_NextPart_000_0010_01C62CC2.ACC81870
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am looking for a Linker Script that would be permit me to run a small =
program entirely in the DPRAM region of a MPC8248. Also, which compiler =
and linker flags do I need for my PC hosted GNU PPC Cross-compiler?  My =
own attempt, results in the Stack being steered outside of  DPRAM. Could =
anyone please assist?

=20

Thanks,

Paul

------=_NextPart_000_0010_01C62CC2.ACC81870
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>Hi,</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><?xml:namespace =
prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p><FONT face=3D"Times New =
Roman"=20
size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>I am looking for a Linker Script that would be permit me to run =
a small=20
program entirely in the DPRAM region of a MPC8248. Also, which compiler =
and=20
linker flags do I need for my PC hosted GNU PPC Cross-compiler?<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>My own attempt, results in the =
Stack=20
being steered outside of<SPAN style=3D"mso-spacerun: yes">&nbsp; =
</SPAN>DPRAM.=20
Could anyone please assist?</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT =
face=3D"Times New Roman"=20
size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>Thanks,</FONT></P>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times =
New Roman"=20
size=3D3>Paul</FONT></P></FONT></DIV></BODY></HTML>

------=_NextPart_000_0010_01C62CC2.ACC81870--
