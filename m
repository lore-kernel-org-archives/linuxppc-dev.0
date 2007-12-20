Return-Path: <Jonathan@elspec-ltd.com>
Received: from mail.elspec-ltd.com (mail.elspec-ltd.com [212.143.246.202])
	by ozlabs.org (Postfix) with ESMTP id 07CDEDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 18:11:03 +1100 (EST)
Received: from mail.elspec-ltd.com (localhost [127.0.0.1])
	by mail.elspec-ltd.com (Proxmox) with ESMTP id 318CD411F99
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 08:52:55 +0200 (IST)
Received: from mailsrv.elspec.local (unknown [100.100.100.3])
	by mail.elspec-ltd.com (Proxmox) with ESMTP id F2838411F97
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 08:52:54 +0200 (IST)
From: Jonathan Journo <Jonathan@elspec-ltd.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Date: Thu, 20 Dec 2007 08:53:07 +0200
Subject: Re: MPC885 - USB HCI drivers.
Message-ID: <8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5F@mailsrv.Elspec.local>
Content-Type: multipart/alternative;
	boundary="_000_8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5FmailsrvElspec_"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--_000_8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5FmailsrvElspec_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Pantelis ,

I saw you used usb host driver on mpc8xx. I am trying to make one on MPC885=
 because vxworks drivers are not compatible with it.

To begin I tried to make the loopback mode (test) working but it doesn't wo=
rk.
Is there anything that is not mentioned on the datasheet in" USB host contr=
oller initialization example" that I have to know to make it work.

Thanks for any help.
Jonathan
Journo.

--_000_8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5FmailsrvElspec_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:right;
	direction:rtl;
	unicode-bidi:embed;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>Hello
Pantelis ,<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>I
saw you used usb host driver on mpc8xx. I am trying to make one on MPC885 b=
ecause
vxworks drivers are not compatible with it.<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>To
begin I tried to make the loopback mode (test) working but it doesn't work.=
<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>Is
there anything that is not mentioned on the datasheet in&quot; USB host
controller initialization example&quot; that I have to know to make it work=
.<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>Thanks
for any help.<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>Jonathan<o:p></o:p></span></p>

<p class=3DMsoNormal align=3Dright dir=3DRTL style=3D'text-align:left'><spa=
n dir=3DLTR>Journo.<o:p></o:p></span></p>

</div>

</body>

</html>

--_000_8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5FmailsrvElspec_--
