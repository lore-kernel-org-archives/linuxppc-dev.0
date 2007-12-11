Return-Path: <ashish.yadav@einfochips.com>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BB2BDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 15:00:43 +1100 (EST)
Received: from unknown (HELO ashish) (ashish.yadav@[192.168.9.119])
	(envelope-sender <ashish.yadav@einfochips.com>)
	by ahmedabad.einfochips.com (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 11 Dec 2007 03:54:15 -0000
From: "ashish" <ashish.yadav@einfochips.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Help:To Add NAND Node  in Device Tree
Date: Tue, 11 Dec 2007 09:30:02 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0099_01C83BD8.689921E0"
Message-Id: <20071211040044.3BB2BDDE0A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0099_01C83BD8.689921E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,   

      I am trying to add Nand Node in Device Tree, for My Board(Some what
similar to MPC8548_CDS). 

      In Board, Nand is attached to LBC UPM Controller. 

      Currently My NAND Driver working Fine without NAND Device Node in
Device Tree.

      But as Requirement, I have to add NAND Device Node in Device Tree.


      Can you give me some basic out lines to carry out this task? 

      I know that: 

          1. I have to make some changes in My NAND Driver to Read Device
Tree.

 

          2. Add NAND Node in Device Tree. But Again What property I need
for It. 

 

           Thanks in Advance.

 

 

With Best Regards

  Ashish Yadav  


-- 
eInfochips Business Disclaimer:
 
This message may contain confidential, proprietary or legally Privileged
information. In case you are not the original intended Recipient of the
message, you must not, directly or indirectly, use, Disclose,distribute,
print, or copy any part of this message and you are requested to delete
it and inform the sender. Any views expressed in this message are those
of the individual sender unless otherwise stated.Nothing contained in
this message shall be construed as an offer or acceptance of any offer
by eInfochips Limited and/or eInfochips Inc(“eInfochips”) unless sent
with that express intent and with due authority of eInfochips.EInfochips
has taken enough precautions to prevent the spread of viruses. However
the company accepts no liability for any damage caused by any virus
transmitted by this email.


------=_NextPart_000_0099_01C83BD8.689921E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hi,&nbsp; =
&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I am trying to add Nand Node in Device Tree, for My Board(Some what =
similar to MPC8548_CDS).
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
In Board, Nand is attached to LBC UPM Controller. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Currently My NAND Driver working Fine without NAND Device Node in Device =
Tree.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
But as Requirement, I have to add NAND Device Node in Device Tree. =
&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Can you give me some basic out lines to carry out this task? =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I know that: <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1. I have to make some changes in My NAND Driver to Read Device =
Tree.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2. Add NAND Node in Device Tree. But Again What property I need for It. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;Thanks
in Advance.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>With Best Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;Ashish Yadav =
&nbsp;<o:p></o:p></span></font></p>

</div>

<BR>
<pre>-- 
eInfochips Business Disclaimer:
 
This message may contain confidential, proprietary or legally Privileged
information. In case you are not the original intended Recipient of the
message, you must not, directly or indirectly, use, Disclose,distribute,
print, or copy any part of this message and you are requested to delete
it and inform the sender. Any views expressed in this message are those
of the individual sender unless otherwise stated.Nothing contained in
this message shall be construed as an offer or acceptance of any offer
by eInfochips Limited and/or eInfochips Inc(“eInfochips”) unless sent
with that express intent and with due authority of eInfochips.EInfochips
has taken enough precautions to prevent the spread of viruses. However
the company accepts no liability for any damage caused by any virus
transmitted by this email.</pre>

<BR>
</body>

</html>

------=_NextPart_000_0099_01C83BD8.689921E0--
