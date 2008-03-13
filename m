Return-Path: <rs@carriercomm.com>
Received: from ccomm-ex1.ccomm.com (unknown [207.158.3.3])
	by ozlabs.org (Postfix) with ESMTP id 5C0B9DDF18
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Mar 2008 03:51:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8852A.80BD8838"
Subject: RE: Using GDB with Abatron's BDI2000 and the ppc405 in the Xilinx
	VirtexII Pro
Date: Thu, 13 Mar 2008 09:51:37 -0700
Message-ID: <EE63F03D9E04774997AEBCD21FC77F251BB1CC@ccomm-ex1.ccomm.com>
From: "Sugathan, Rupesh" <rs@carriercomm.com>
To: "Wood, Robert \(GE EntSol,
	Intelligent Platforms\)" <robert.wood@gefanuc.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8852A.80BD8838
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We need a simple description of how to get GDB running with the BDI2000.
We have the '2000 communicating and can access the registers and like
through the telnet link but don't know how to configure the unit or GDB
to work together.

=20

See if these helps

http://www.unimax.co.kr/unimax_2003_11/products/datasheets/ManGDBPPC-200
0C5.pdf
http://microcross.com/Debugging_Linux_Kernel.pdf
<http://microcross.com/Debugging_Linux_Kernel.pdf>=20

 http://ultsol.com/pdfs/ <http://ultsol.com/pdfs/>=20

=20

Thanks
--
Rupesh Sugathan

=20

=20


------_=_NextPart_001_01C8852A.80BD8838
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:st1 =3D=20
"urn:schemas-microsoft-com:office:smarttags"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR><o:SmartTagType =

name=3D"country-region"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"State"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"City"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"place"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"Street"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><o:SmartTagType=20
name=3D"address"=20
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"></o:SmartTagT=
ype><!--[if !mso]>
<STYLE>st1\:* {
	BEHAVIOR: url(#default#ieooui)
}
</STYLE>
<![endif]-->
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: personal-compose
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">We need a simple =
description of how=20
to get GDB running with the BDI2000. We have the &#8216;2000 =
communicating and can=20
access the registers and like through the telnet link but don&#8217;t =
know how to=20
configure the unit or GDB to work =
together.<o:p></o:p></SPAN></FONT></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT>&nbsp;</P>
<P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p><SPAN=20
class=3D382273916-13032008>See if these helps</SPAN></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p><SPAN=20
class=3D382273916-13032008><A=20
href=3D"http://www.unimax.co.kr/unimax_2003_11/products/datasheets/ManGDB=
PPC-2000C5.pdf">http://www.unimax.co.kr/unimax_2003_11/products/datasheet=
s/ManGDBPPC-2000C5.pdf</A><BR><A=20
href=3D"http://microcross.com/Debugging_Linux_Kernel.pdf" =
target=3D_blank><FONT=20
face=3D"Times New Roman"=20
size=3D3>http://microcross.com/Debugging<WBR>_Linux_Kernel.pdf</FONT></A>=
</SPAN></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p><SPAN=20
class=3D382273916-13032008><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p><SPAN=20
class=3D382273916-13032008><A href=3D"http://ultsol.com/pdfs/" =
target=3D_blank><FONT=20
face=3D"Times New Roman"=20
size=3D3>&nbsp;http://ultsol.com/pdfs/</FONT></A></SPAN></o:p></SPAN></SP=
AN></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p><SPAN=20
class=3D382273916-13032008></SPAN></o:p></SPAN>&nbsp;</P><FONT =
face=3DArial=20
size=3D2><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><o:p>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>--</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Rupesh =
Sugathan</FONT></DIV>
<P class=3DMsoNormal>&nbsp;</o:p></SPAN></FONT></P>
<P class=3DMsoNormal><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
style=3D"FONT-SIZE: =
12pt"><o:p></o:p></SPAN></FONT>&nbsp;</P></DIV></BODY></HTML>

------_=_NextPart_001_01C8852A.80BD8838--
