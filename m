Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 00287B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 05:05:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB9314.65A3EF24"
Subject: RE: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Fri, 3 Dec 2010 10:04:03 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520162CA22@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <267A3B246C22C34A8E574051858E077002E834@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1290063473-20950-1-git-send-email-b21989@freescale.com><0CE8B6BE3C4AD74AB97D9D29BD24E552015F5E40@CORPEXCH1.na.ads.idt.com>
	<267A3B246C22C34A8E574051858E077002E834@039-SN1MPN1-003.039d.mgd.msft.net>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Xie Shaohui-B21989" <B21989@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: akpm@linux-foundation.org, Zang Roy-R61911 <r61911@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB9314.65A3EF24
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think they should follow the previous two that are in Kumar's tree.

Probably Kumar may give you a better timeline estimate for this.  =20

=20

Alex.

=20

From: linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org=
]
On Behalf Of Xie Shaohui-B21989
Sent: Thursday, December 02, 2010 10:29 PM
To: Bounine, Alexandre; linuxppc-dev@lists.ozlabs.org
Cc: akpm@linux-foundation.org; Gala Kumar-B11780; Li Yang-R58472; Zang
Roy-R61911
Subject: RE: [PATCH 2/2][v3] rapidio,powerpc/85xx: Error interrupt
handler for sRIO.

=20

Hi Alex,

=20

May I ask when would these patches be applied to mainline?

=20

=20

Best Regards,=20
Shaohui Xie=20

=20

From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
Sent: Wednesday, December 01, 2010 4:49 AM
To: Xie Shaohui-B21989; linuxppc-dev@lists.ozlabs.org
Cc: akpm@linux-foundation.org; Li Yang-R58472; Gala Kumar-B11780; Zang
Roy-R61911
Subject: RE: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
handler for sRIO.

=20

Applies correctly now. Lab tested on 8548/RIO setup.

Alex.

> -----Original Message-----
> From: Shaohui Xie [mailto:b21989@freescale.com]
> Sent: Thursday, November 18, 2010 1:58 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Shaohui Xie; Li Yang; Kumar Gala; Roy
Zang; Bounine, Alexandre
> Subject: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
handler for sRIO.
>
> The sRIO controller reports errors to the core with one signal, it
uses
> register EPWISR to provides the core quick access to where the error
occurred.
> The EPWISR indicates that there are 4 interrupts sources, port1,
port2, message
> unit and port write receive, but the sRIO driver does not support
port2
> for now, still the handler takes care of port2.
> Currently the handler only clear error status without any recovery.


------_=_NextPart_001_01CB9314.65A3EF24
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><title>RE: [PATCH 2/2][v3] rapidio, powerpc/85xx: =
Error interrupt handler for sRIO.</title><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>I think they should follow the previous two that are in Kumar&#8217;s =
tree.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Probably Kumar may give you a better timeline estimate for this. =
&nbsp;&nbsp;<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Alex.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div =
style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4DF =
1.0pt;padding:3.0pt 0in 0in 0in'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org=
] <b>On Behalf Of </b>Xie Shaohui-B21989<br><b>Sent:</b> Thursday, =
December 02, 2010 10:29 PM<br><b>To:</b> Bounine, Alexandre; =
linuxppc-dev@lists.ozlabs.org<br><b>Cc:</b> akpm@linux-foundation.org; =
Gala Kumar-B11780; Li Yang-R58472; Zang Roy-R61911<br><b>Subject:</b> =
RE: [PATCH 2/2][v3] rapidio,powerpc/85xx: Error interrupt handler for =
sRIO.<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Hi Alex,<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>May I ask when would these patches be applied to =
mainline?<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue'><o=
:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue'>Be=
st Regards,</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'> <br></span><span =
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue'>Sh=
aohui Xie</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'> <o:p></o:p></span></p></div><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div =
style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4DF =
1.0pt;padding:3.0pt 0in 0in 0in'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com] <br><b>Sent:</b> =
Wednesday, December 01, 2010 4:49 AM<br><b>To:</b> Xie Shaohui-B21989; =
linuxppc-dev@lists.ozlabs.org<br><b>Cc:</b> akpm@linux-foundation.org; =
Li Yang-R58472; Gala Kumar-B11780; Zang Roy-R61911<br><b>Subject:</b> =
RE: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt handler for =
sRIO.<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
style=3D'margin-bottom:12.0pt'><span style=3D'font-size:10.0pt'>Applies =
correctly now. Lab tested on 8548/RIO setup.<br><br>Alex.<br><br>&gt; =
-----Original Message-----<br>&gt; From: Shaohui Xie [<a =
href=3D"mailto:b21989@freescale.com">mailto:b21989@freescale.com</a>]<br>=
&gt; Sent: Thursday, November 18, 2010 1:58 AM<br>&gt; To: =
linuxppc-dev@lists.ozlabs.org<br>&gt; Cc: akpm@linux-foundation.org; =
Shaohui Xie; Li Yang; Kumar Gala; Roy<br>Zang; Bounine, =
Alexandre<br>&gt; Subject: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error =
interrupt<br>handler for sRIO.<br>&gt;<br>&gt; The sRIO controller =
reports errors to the core with one signal, it<br>uses<br>&gt; register =
EPWISR to provides the core quick access to where the =
error<br>occurred.<br>&gt; The EPWISR indicates that there are 4 =
interrupts sources, port1,<br>port2, message<br>&gt; unit and port write =
receive, but the sRIO driver does not support<br>port2<br>&gt; for now, =
still the handler takes care of port2.<br>&gt; Currently the handler =
only clear error status without any =
recovery.</span><o:p></o:p></p></div></div></div></body></html>
------_=_NextPart_001_01CB9314.65A3EF24--
