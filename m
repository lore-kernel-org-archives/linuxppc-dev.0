Return-Path: <cdry@mc.com>
Received: from chm-mail.mc.com (iris-63.mc.com [63.96.239.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61EC7B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Dec 2010 05:28:08 +1100 (EST)
Received: from chm-cashub1.ad.mc.com (exchange [172.18.12.34])
	by chm-mail.mc.com (8.13.8+Sun/8.13.8) with ESMTP id oBKI8uIb010919
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Dec 2010 13:08:56 -0500 (EST)
From: "Dry, Craig" <cdry@mc.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 20 Dec 2010 13:08:55 -0500
Subject: P2020 with BCM53115
Message-ID: <690FFE9537DC4C47854ABD6C16FA141945A2AC3D5F@CHM-MBX1.ad.mc.com>
Content-Type: multipart/alternative;
	boundary="_000_690FFE9537DC4C47854ABD6C16FA141945A2AC3D5FCHMMBX1admcco_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_690FFE9537DC4C47854ABD6C16FA141945A2AC3D5FCHMMBX1admcco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to bring up a P2020 board which uses the Broadcom BCM53115 swit=
ch in unmanaged mode.  The board is patterned after the P2020RDB, except th=
e Vitesse switch has been replaced with a BCM53115. There is no MDIO connec=
tion to the switch, but there is  an SPI connection available if needed.

When running Uboot, the BCM53115 works just fine, as I am able to download =
the Linux Kernel and P2020RDB.dtb across the network without issue.   But a=
s Linux is booting up, I get the message:

mdio_bus mdio@ffe24520: error probing PHY at address 0
mdio_bus mdio@ffe24520: error probing PHY at address 1

I expect these errors occur because the P2020RDB.dts file has these entries=
.

I'm not sure what to try next to get Linux to use the BCM53115 switch in un=
managed mode.

Any help is appreciated,
Thanks,
Craig

This message is intended only for the designated recipient(s) and may conta=
in confidential or proprietary information of Mercury Computer Systems, Inc=
.  This message is solely intended to facilitate business discussions and d=
oes not constitute an express or implied offer to sell or purchase any prod=
ucts, services, or support.  Any commitments must be made in writing and si=
gned by duly authorized representatives of each party.


--_000_690FFE9537DC4C47854ABD6C16FA141945A2AC3D5FCHMMBX1admcco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:wf=3D"http:/=
/schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:dsss=3D"http://sche=
mas.microsoft.com/office/2006/digsig-setup" xmlns:dssi=3D"http://schemas.mi=
crosoft.com/office/2006/digsig" xmlns:mdssi=3D"http://schemas.openxmlformat=
s.org/package/2006/digital-signature" xmlns:mver=3D"http://schemas.openxmlf=
ormats.org/markup-compatibility/2006" xmlns:m=3D"http://schemas.microsoft.c=
om/office/2004/12/omml" xmlns:mrels=3D"http://schemas.openxmlformats.org/pa=
ckage/2006/relationships" xmlns:spwp=3D"http://microsoft.com/sharepoint/web=
partpages" xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/20=
06/types" xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/200=
6/messages" xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/Sli=
deLibrary/" xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortal=
Server/PublishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:=
st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

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
	{margin:0in;
	margin-bottom:.0001pt;
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
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
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

<div class=3DWordSection1>

<p class=3DMsoNormal>I am trying to bring up a P2020 board which uses the
Broadcom BCM53115 switch in unmanaged mode.&nbsp; The board is patterned af=
ter
the P2020RDB, except the Vitesse switch has been replaced with a BCM53115. =
There
is no MDIO connection to the switch, but there is&nbsp; an SPI connection
available if needed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>When running Uboot, the BCM53115 works just fine, as I=
 am
able to download the Linux Kernel and P2020RDB.dtb across the network witho=
ut
issue.&nbsp;&nbsp; But as Linux is booting up, I get the message:<o:p></o:p=
></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>mdio_bus mdio@ffe24520: error probing PHY at address 0=
<o:p></o:p></p>

<p class=3DMsoNormal>mdio_bus mdio@ffe24520: error probing PHY at address 1=
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I expect these errors occur because the P2020RDB.dts f=
ile
has these entries.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m not sure what to try next to get Linux to us=
e the
BCM53115 switch in unmanaged mode.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Any help is appreciated,<o:p></o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal>Craig<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:7.5pt;font-family:"Arial","sa=
ns-serif"'>This
message&nbsp;is intended only for the designated recipient(s) and may conta=
in
confidential or proprietary information of Mercury Computer Systems, Inc.&n=
bsp;
This message is solely intended to facilitate business discussions and does=
 not
constitute an express or implied offer to sell or purchase any products,
services, or support.&nbsp; Any commitments must be made in writing and sig=
ned
by duly authorized representatives of each party.</span><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_690FFE9537DC4C47854ABD6C16FA141945A2AC3D5FCHMMBX1admcco_--
