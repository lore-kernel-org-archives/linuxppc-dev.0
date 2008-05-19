Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 61C4FDE133
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 03:59:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B9DA.228ABEC6"
Subject: RE: Instruction OCM
Date: Mon, 19 May 2008 12:59:51 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C11@XMBIL132.northgrum.com>
In-Reply-To: <012401c8b9c3$74b947c0$5e2bd740$@com>
References: <012401c8b9c3$74b947c0$5e2bd740$@com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B9DA.228ABEC6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

How is your IOCM actually built into your system, i.e. what is its base
address? It cannot overlap with any other memory address in the system.
=20
-- Mike

________________________________

From: mojtaba [mailto:kernelppc@gmail.com]=20
Sent: Monday, May 19, 2008 11:17 AM
To: linuxppc-embedded@ozlabs.org
Subject: Instruction OCM



Dear all,

I cannot run Linux when I have an instruction OCM in my design but,
without instruction OCM everything is fine. I tried to do some
debugging. It seems that the Linux memory management unit has a problem
with that.  After entering the MMU initialization phase, it suddenly
jumps to address 0x00000700 it get stuck there. Is there anybody who
have tried a design with instruction OCM? Do I need to do special
configuration for the Linux kernel?=20

Regards,

Mojtaba


------_=_NextPart_001_01C8B9DA.228ABEC6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3314" name=3DGENERATOR>
<STYLE>@font-face {
	font-family: Calibri;
}
@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.0in 1.0in 1.0in; }
P.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
LI.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
DIV.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal-compose
}
.MsoChpDefault {
	mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D535075917-19052008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>How is your IOCM actually built into your =
system, i.e. what=20
is its base address? It cannot overlap with any other memory address in =
the=20
system.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D535075917-19052008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D535075917-19052008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>-- Mike</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> mojtaba =
[mailto:kernelppc@gmail.com]=20
<BR><B>Sent:</B> Monday, May 19, 2008 11:17 AM<BR><B>To:</B>=20
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Instruction=20
OCM<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal>Dear all,<o:p></o:p></P>
<P class=3DMsoNormal>I cannot run Linux when I have an instruction OCM =
in my=20
design but, without instruction OCM everything is fine. I tried to do =
some=20
debugging. It seems that the Linux memory management unit has a problem =
with=20
that. &nbsp;After entering the MMU initialization phase, it suddenly =
jumps to=20
address 0x00000700 it get stuck there. Is there anybody who have tried a =
design=20
with instruction OCM? Do I need to do special configuration for the =
Linux=20
kernel? <o:p></o:p></P>
<P class=3DMsoNormal>Regards,<o:p></o:p></P>
<P class=3DMsoNormal>Mojtaba<o:p></o:p></P></DIV></BODY></HTML>

------_=_NextPart_001_01C8B9DA.228ABEC6--
