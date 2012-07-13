Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B6202C0363
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 22:57:21 +1000 (EST)
Received: from mail.idt.com (localhost [127.0.0.1])
 by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id q6DCmSnw030236
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 05:48:28 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
 by mail.idt.com (8.13.8/8.13.8) with ESMTP id q6DCmRkE004537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 05:48:27 -0700 (PDT)
Received: from corpmail2.na.ads.idt.com (localhost [127.0.0.1])
 by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id q6DCmRv08149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 05:48:27 -0700 (PDT)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Standalone SRIO Driver for Linux
Date: Fri, 13 Jul 2012 12:48:25 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D10285E9@corpmail1.na.ads.idt.com>
References: <CAEqOc-QpXcwbLuJXLbGv3VgccKnkMrdGV+ZdwFaFZCzjG3K7Mw@mail.gmail.com>
In-Reply-To: <CAEqOc-QpXcwbLuJXLbGv3VgccKnkMrdGV+ZdwFaFZCzjG3K7Mw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="_000_8D983423E7EDF846BB3056827B8CC5D10285E9corpmail1naadsidt_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--_000_8D983423E7EDF846BB3056827B8CC5D10285E9corpmail1naadsidt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This should work. We use similar approach to test our mport HW drivers.

Alex.

From: Linuxppc-dev [mailto:linuxppc-dev-bounces+alexandre.bounine=3Didt.com=
@lists.ozlabs.org] On Behalf Of Saravanan S
Sent: Friday, July 13, 2012 2:16 AM
To: linuxppc-dev@lists.ozlabs.org
Subject: Standalone SRIO Driver for Linux

Hi ,
      Iam currently working on the GE make DSP230 board consisting of Quad =
PowerPC8640 nodes   interconnected by SRIO with Linux 2.6.34 . However the =
only way to access the SRIO is through rionet facility . Our requirement is=
 to use the SRIO interconnect without the Ethernet overheads. This would de=
finitely enable higher speeds (though I cant find any throughput figures fo=
r SRIO in Linux on the net ??? ).  My query is that whether any attempt has=
 been made  to develop a  standalone driver and API to access the messaging=
  and doorbell services of SRIO . If no then request you to please provide =
inputs on the same. From my study I have the following thoughts for the dri=
ver :

a) Have a character device interface for user .
b) Basically use the rio support functions provided in rio.c like  rio_add_=
inb_buffer ,  rio_add_outb_message to transfer and receive messages and add=
 buffers .
c) Maintain a dedicated ring of buffers in the driver and transfer  data to=
 and from the buffer to user space .


Is this the right direction . Would really appreciate any inputs . thanks i=
n advance.

Regards,

S.Saravanan

--_000_8D983423E7EDF846BB3056827B8CC5D10285E9corpmail1naadsidt_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
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
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">This should work. We use =
similar approach to test our mport HW drivers.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Linuxppc=
-dev [mailto:linuxppc-dev-bounces&#43;alexandre.bounine=3Didt.com@lists.ozl=
abs.org]
<b>On Behalf Of </b>Saravanan S<br>
<b>Sent:</b> Friday, July 13, 2012 2:16 AM<br>
<b>To:</b> linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> Standalone SRIO Driver for Linux<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi ,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Iam currently working on the GE make DSP230 =
board consisting of Quad PowerPC8640 nodes &nbsp; interconnected by SRIO wi=
th Linux 2.6.34 . However the only way to access the SRIO is through rionet=
 facility . Our requirement is to use the SRIO interconnect without
 the Ethernet overheads. This would definitely enable higher speeds (though=
 I cant find any throughput figures for SRIO in Linux on the net ??? ).&nbs=
p; My query is that whether any attempt has been made&nbsp; to develop a&nb=
sp; standalone driver and API to access the messaging&nbsp;
 and doorbell services of SRIO . If no then request you to please provide i=
nputs on the same. From my study I have the following thoughts for the driv=
er :<br>
<br>
a) Have a character device interface for user .<br>
b) Basically use the rio support functions provided in rio.c like&nbsp; rio=
_add_inb_buffer ,&nbsp; rio_add_outb_message to transfer and receive messag=
es and add buffers .<br>
c) Maintain a dedicated ring of buffers in the driver and transfer&nbsp; da=
ta to and from the buffer to user space .<br>
<br>
<br>
Is this the right direction . Would really appreciate any inputs . thanks i=
n advance.<br>
<br>
Regards,<br>
<br>
S.Saravanan<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_8D983423E7EDF846BB3056827B8CC5D10285E9corpmail1naadsidt_--
