Return-Path: <mmaclean@symbotic.com>
Received: from mail132.messagelabs.com (mail132.messagelabs.com
 [216.82.242.115])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail132.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AE3C2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2012 05:05:59 +1100 (EST)
From: Maxwell MacLean <mmaclean@symbotic.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 16 Nov 2012 12:05:52 -0600
Subject: MPC52xx_uart low_latency
Message-ID: <8B0DFD3F5522AD4A93E19D93119191C16EB487165E@AUSP01VMBX06.collaborationhost.net>
Content-Type: multipart/alternative;
 boundary="_000_8B0DFD3F5522AD4A93E19D93119191C16EB487165EAUSP01VMBX06c_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_8B0DFD3F5522AD4A93E19D93119191C16EB487165EAUSP01VMBX06c_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello fellow PPC developers.

My name is Max MacLean, a new subscriber to this list. Thanks for taking my=
 call.
Since I cannot find a way to easily search the archives, I'll ask directly.

Is anyone working on or aware of a patch the MPC52xx_uart driver to provide=
 a 'low_latency' option.

I want to be able to do this (in c++)

struct serial_struct ss;
if(ioctl(m_iSerial, TIOCGSERIAL, &ss))
{
  ss.flags |=3D ASYNC_LOW_LATENCY;
  ioctl(m_iSerial, TIOCSSERIAL, &ss))
}


or  from command line  type  setserial /dev/ttyPSC1 low_latency

I am trying to get data from my fifo into Linux faster. I am currently seei=
ng a 3-8 msec latency
between characters read in the uart and arrival at the tty. It seems like i=
t's a problem that
has been solved on other platforms


best regards,
 Max
__________________________________

Maxwell MacLean | Senior Firmware Engineer
SYMBOTIC LLC

--_000_8B0DFD3F5522AD4A93E19D93119191C16EB487165EAUSP01VMBX06c_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hello fellow PPC=
 developers. <o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p cl=
ass=3DMsoNormal>My name is Max MacLean, a new subscriber to this list. Than=
ks for taking my call.<o:p></o:p></p><p class=3DMsoNormal>Since I cannot fi=
nd a way to easily search the archives, I&#8217;ll ask directly. <o:p></o:p=
></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Is anyo=
ne working on or aware of a patch the MPC52xx_uart driver to provide a &#82=
16;low_latency&#8217; option.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp=
;</o:p></p><p class=3DMsoNormal>I want to be able to do this (in c++)<o:p><=
/o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>str=
uct serial_struct ss;<o:p></o:p></p><p class=3DMsoNormal>if(ioctl(m_iSerial=
, TIOCGSERIAL, &amp;ss))<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p=
><p class=3DMsoNormal>&nbsp; ss.flags |=3D ASYNC_LOW_LATENCY;<o:p></o:p></p=
><p class=3DMsoNormal>&nbsp; ioctl(m_iSerial, TIOCSSERIAL, &amp;ss))<o:p></=
o:p></p><p class=3DMsoNormal>}<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbs=
p;</o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>=
or &nbsp;from command line&nbsp; type&nbsp; setserial /dev/ttyPSC1 low_late=
ncy<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoN=
ormal>I am trying to get data from my fifo into Linux faster. I am currentl=
y seeing a 3-8 msec latency<o:p></o:p></p><p class=3DMsoNormal>between char=
acters read in the uart and arrival at the tty. It seems like it&#8217;s a =
problem that<o:p></o:p></p><p class=3DMsoNormal>has been solved on other pl=
atforms <o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>best regards, <o:p><=
/o:p></p><p class=3DMsoNormal>&nbsp;Max<o:p></o:p></p><p class=3DMsoNormal>=
<span style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";color:#3=
5D4C7'>__________________________________</span><span style=3D'color:#1F497=
D'><o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:13.5=
pt;font-family:"Verdana","sans-serif";color:black'><o:p>&nbsp;</o:p></span>=
</p><p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Ve=
rdana","sans-serif";color:#616566'>Maxwell MacLean</span></b><span style=3D=
'font-size:9.0pt;font-family:"Arial","sans-serif";color:#616566'>&nbsp;</sp=
an><span style=3D'font-size:9.0pt;font-family:"Verdana","sans-serif";color:=
#616566'>|&nbsp;</span><span style=3D'font-size:10.0pt;color:#595959'>Senio=
r Firmware Engineer</span><span style=3D'color:#616566'> <br></span><b><spa=
n style=3D'font-size:9.0pt;font-family:"Arial","sans-serif";color:#616566'>=
SYMBOTIC LLC</span></b><span style=3D'font-size:13.5pt;font-family:"Verdana=
","sans-serif";color:black'><o:p></o:p></span></p></div></body></html>=

--_000_8B0DFD3F5522AD4A93E19D93119191C16EB487165EAUSP01VMBX06c_--
