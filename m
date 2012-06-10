Return-Path: <graman@arubanetworks.com>
Received: from sjcbarracuda02.arubanetworks.com
 (sjcbarracuda02.arubanetworks.com [199.127.104.60])
 by ozlabs.org (Postfix) with ESMTP id 15787B6FD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 06:52:24 +1000 (EST)
Received: from DIAMONDPEAK.arubanetworks.com (diamondpeak.arubanetworks.com
 [10.1.8.23]) by sjcbarracuda02.arubanetworks.com with ESMTP id
 TtmWSAeEwoNOCFsk for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 10 Jun 2012 13:52:22 -0700 (PDT)
From: Gopalakrishnan Raman <graman@arubanetworks.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: 
Date: Sun, 10 Jun 2012 20:52:20 +0000
Message-ID: <802E1C77E421D345A43385A6BFAC7AC4BE5076@ROYALGORGE.arubanetworks.com>
Content-Type: multipart/alternative;
 boundary="_000_802E1C77E421D345A43385A6BFAC7AC4BE5076ROYALGORGEarubane_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_802E1C77E421D345A43385A6BFAC7AC4BE5076ROYALGORGEarubane_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi
The P1020 manual states (in the PIC chapter) that in the "Internal Interrup=
t Destination" register, only 1 CPU (and not both) can be selected as the I=
RQ destination. How then can we achieve "interrupt spraying" for the PCI in=
terrupt (we want interrupts to be sent alternately to CPU0 and CPU1). Also,=
  we changed the code to ignore the MPIC_SINGLE_DEST_CPU flag and set both =
CPUs in the destination of the PIC_IIDRn register. This does seem to work. =
But we're not sure if we can rely on this behavior and whether it will caus=
e other problems.
Any advice appreciated
Thanks
-gopal


--_000_802E1C77E421D345A43385A6BFAC7AC4BE5076ROYALGORGEarubane_
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<p class=3D"MsoNormal">The P1020 manual states (in the PIC chapter) that in=
 the &#8220;Internal Interrupt Destination&#8221; register, only 1 CPU (and=
 not both) can be selected as the IRQ destination. How then can we achieve =
&#8220;interrupt spraying&#8221; for the PCI interrupt (we
 want interrupts to be sent alternately to CPU0 and CPU1). Also, &nbsp;we c=
hanged the code to ignore the MPIC_SINGLE_DEST_CPU flag and set both CPUs i=
n the destination of the PIC_IIDRn register. This does seem to work. But we=
&#8217;re not sure if we can rely on this behavior
 and whether it will cause other problems.<o:p></o:p></p>
<p class=3D"MsoNormal">Any advice appreciated<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">-gopal<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_802E1C77E421D345A43385A6BFAC7AC4BE5076ROYALGORGEarubane_--
