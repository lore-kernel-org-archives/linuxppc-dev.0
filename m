Return-Path: <Syamala_Reddy@mindtree.com>
Received: from mailwo11.mindtree.com (unknown [203.200.60.136])
	by ozlabs.org (Postfix) with ESMTP id 1C397DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 19:12:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/related; type="multipart/alternative";
	boundary="----_=_NextPart_001_01C7E0AD.0B18BAD4"
Subject: How to set non standurd baud rate on MPC5200 UART.
Date: Fri, 17 Aug 2007 14:30:57 +0530
Message-ID: <16271F716C971E4BBBE29C45FA4A0138054C7C08@mtw01ex01.mindtree.com>
From: "Syamala Venugopal Reddy" <Syamala_Reddy@mindtree.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C7E0AD.0B18BAD4
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7E0AD.0B18BAD4"


------_=_NextPart_002_01C7E0AD.0B18BAD4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 =20

tried to set non standard baud rate using tty calls.

Code snipped as fallows.

=20

baudrate=3D5;

ret=3Dioctl(fd, TIOCGSERIAL, &serial_info);

if(ret!=3D0)

{

   perror("custom baud rate get");

}

serial_info.flags &=3D ~ASYNC_SPD_MASK;

serial_info.flags |=3D ASYNC_SPD_CUST;

=20

serial_info.custom_divisor=3Dserial_info.baud_base / baudrate;

ret=3Dioctl(fd, TIOCSSERIAL,&serial_info);

if(ret!=3D0)

{

        perror("custom baud rate set:");

}

=20

This code compiles well but gives error as

"Custom baud rate set: invalid argument" in run time.

=20

=20

=20

=20

Is there any thing wrong in this code?

=20

Any one worked on MPC52XX, PSC controller provided by Freescale?

=20

Does this serial driver (mpc52xx) supports custom baud rates?

=20

Even the following code also giving me the same error. (This will just =
get
the options and set the same options with out modifying)

=20

ret=3Dioctl(fd, TIOCGSERIAL, &serial_info);

ret=3Dioctl(fd, TIOCSSERIAL,&serial_info);

=20

=20

Thanks and Regards,=20

Venu ,=20

=20



DISCLAIMER:
This message (including attachment if any) is confidential and may be =
privileged. Before opening attachments please check them for viruses and =
defects. MindTree Consulting Limited (MindTree) will not be responsible =
for any viruses or defects or any forwarded attachments emanating either =
from within MindTree or outside. If you have received this message by =
mistake please notify the sender by return  e-mail and delete this =
message from your system. Any unauthorized use or dissemination of this =
message in whole or in part is strictly prohibited.Please note that =
e-mails are susceptible to change and MindTree shall not be liable for =
any improper, untimely or incomplete transmission.
E-mail may contain viruses. Before opening attachments please check them =
for viruses and defects. While MindTree Consulting Limited (MindTree) =
has put in place checks to minimize the risks, MindTree will not be =
responsible for any viruses or defects or any forwarded attachments =
emanating either from within MindTree or outside.=20

------_=_NextPart_002_01C7E0AD.0B18BAD4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta name=3D"Microsoft Theme 2.00" content=3D"axis 011">
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:Verdana;
	color:black;}
h1
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:16.0pt;
	font-family:Arial;
	color:black;}
h2
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	color:black;
	font-weight:normal;}
h3
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:13.0pt;
	font-family:Arial;
	color:black;
	font-weight:normal;}
h4
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Verdana;
	color:black;
	font-weight:normal;}
h5
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:13.0pt;
	font-family:Verdana;
	color:black;
	font-weight:normal;}
h6
	{margin-top:12.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	font-size:11.0pt;
	font-family:Verdana;
	color:black;
	font-weight:normal;}
a:link, span.MsoHyperlink
	{color:#339933;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:#996600;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<body bgcolor=3Dwhite background=3D"cid:image001.gif@01C7E0DB.39EF9250" =
lang=3DEN-US
link=3D"#339933" vlink=3D"#996600">
<img src=3D"cid:image001.gif@01C7E0DB.39EF9250"
v:src=3D"cid:image001.gif@01C7E0DB.39EF9250" v:shapes=3D"_x0000_Mail" =
width=3D0
height=3D0 class=3Dshape style=3D'display:none;width:0;height:0'><!--[if =
gte mso 9]><xml>
 <v:background id=3D"_x0000_s1025" o:bwmode=3D"white" =
o:targetscreensize=3D"800,600">
  <v:fill src=3D"cid:image001.gif@01C7E0DB.39EF9250" =
o:title=3D"axibkgnd" type=3D"frame" />
 </v:background></xml><![endif]-->

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>tried to set non standard =
baud rate
using tty calls.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>Code snipped as =
fallows.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>baudrate=3D5;<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>ret=3Dioctl(fd, TIOCGSERIAL,
&amp;serial_info);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>if(ret!=3D0)<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>{<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>&nbsp;&nbsp; =
perror(&quot;custom
baud rate get&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>}<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>serial_info.flags &amp;=3D
~ASYNC_SPD_MASK;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>serial_info.flags |=3D =
ASYNC_SPD_CUST;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>serial_info.custom_divisor=3Ds=
erial_info.baud_base
/ baudrate;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>ret=3Dioctl(fd,
TIOCSSERIAL,&amp;serial_info);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>if(ret!=3D0)<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>{<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
perror(&quot;custom baud rate set:&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>}<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>This code compiles well but =
gives
error as<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>&#8220;Custom baud rate set: =
invalid
argument&#8221; in <b><u><span style=3D'font-weight:bold'>run =
time</span></u></b>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>Is there any thing wrong in =
this
code?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>Any one worked on MPC52XX, =
PSC
controller provided by Freescale?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>Does this serial driver =
(mpc52xx)
supports custom baud rates?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>Even the following code also =
giving
me the same error. (This will just get the options and set the same =
options
with out modifying)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>ret=3Dioctl(fd, TIOCGSERIAL,
&amp;serial_info);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'>ret=3Dioctl(fd,
TIOCSSERIAL,&amp;serial_info);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DArial><span =
style=3D'font-size:
12.0pt;font-family:Arial;color:windowtext'><o:p>&nbsp;</o:p></span></font=
></p>

<p class=3DMsoNormal><em><i><font size=3D2 color=3Dpurple =
face=3DVerdana><span
style=3D'font-size:11.0pt;font-family:Verdana;color:purple;font-style:nor=
mal'>Thanks
and Regards, </span></font></i></em><i><font size=3D2 =
color=3Dpurple><span
style=3D'font-size:11.0pt;color:purple;font-style:italic'><o:p></o:p></sp=
an></font></i></p>

<p class=3DMsoNormal><em><i><font size=3D2 color=3Dpurple =
face=3DVerdana><span
style=3D'font-size:11.0pt;font-family:Verdana;color:purple;font-style:nor=
mal'>Venu
, </span></font></i></em><i><font color=3Dblack face=3D"Times New =
Roman"><span
style=3D'font-family:"Times New =
Roman";color:windowtext;font-style:italic'><o:p></o:p></span></font></i><=
/p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3DVerdana><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

<p></p><p><b>DISCLAIMER:</b><br><br>This message (including attachment =
if any) is confidential and may be privileged. If you have received this =
message by mistake please notify the sender by return e-mail and delete =
this message from your system. Any unauthorized use or dissemination of =
this message in whole or in part is strictly prohibited.</p><p>E-mail =
may contain viruses. Before opening attachments please check them for =
viruses and defects. While MindTree Consulting Limited (MindTree) has =
put in place checks to minimize the risks, MindTree will not be =
responsible for any viruses or defects or any forwarded attachments =
emanating either from within MindTree or outside.</p> <p>Please note =
that e-mails are susceptible to change and MindTree shall not be liable =
for any improper, untimely or incomplete transmission.</p> <p>MindTree =
reserves the right to monitor and review the content of all messages =
sent to or from MindTree e-mail address. Messages sent to or from this =
e-mail address may be stored on the MindTree e-mail system or else =
where.</p></body>

</html>

------_=_NextPart_002_01C7E0AD.0B18BAD4--

------_=_NextPart_001_01C7E0AD.0B18BAD4
Content-Type: image/gif;
	name="image001.gif"
Content-Transfer-Encoding: base64
Content-ID: <image001.gif@01C7E0DB.39EF9250>
Content-Description: image001.gif
Content-Location: image001.gif

R0lGODlhZABkAPcAAJkAM/8zZswAM/8AM/+ZmcwzZv/M/8xmmZkzZmYAM8wzmf+ZzP9mzP+Z//9m
mcwAZv8AZv8zmf8Amf8zzP8AzP9m//8z//9QUNYAk5kAZsxmzMwzzMyZ/8xm/8wz/5kzmcwAzMwA
/5kAzJkAmcyZzJlmmWYzZmYAmZkzzGYAZpkA/5kz/5lmzDMAM2YzmWYzzGYAzJlm/zMAZmYA/2Yz
/8zM/5mZ/5mZzGZmzGZm/2ZmmTMzZjMzmTMAmTMAzDMAzDMz/zMzzABm/wAzzDNm/zNmzAAAZgAA
MwAA/wAAmQAzzAAAzDNmmQBmzJnM/2aZ/wAzZmaZzABmmTOZzACZzGbM/zOZ/wAzmQCZ/zPM/wDM
/5n//2b//wAzMwD//wDMzACZmWaZmZnMzMz//zPMzGbMzDOZmTNmZgBmZgAzMwD/zDP/zDPMmQDM
mWb/zJn/zAD/mTOZZgBmMzNmM2aZZmbMZpn/mWb/ZjOZM5nMmWb/mTP/mTPMZgDMZmbMmQCZZgCZ
MzP/ZgD/Zsz/zMz/mZn/Zpn/MwDMMzP/MwDMMzPMMzPMM2b/M2bMMwBmAAAzAACZADPMAGb/AJn/
AGbMAADMADPMADOZAJnMZmaZM5nMMzNmAGaZAJnMAMz/Zsz/M8z/AJmZAMzMAMzMMzMzAGZmAJmZ
M8zMZmZmM5mZZszMmf//zP//mf//Zv//M///AP/MAP/MZv/MM8yZM5lmAMyZAP+ZAMxmAJkzAMxm
M2YzAP+ZZv9mM/+ZM/9mAMwzAJlmMzMAAGYzM5lmZsyZmZkzM8xmZv/MzP8zM8wzM/9mZmYAAJkA
AMwAAP8AAP8zAMyZZv/MmczMzJmZmWZmZjMzMwAAAP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAZABkAAAI/wCvCRxI
sKDBgwgTKlzIsKHDhwNVQZwYkeJEVRIRZoS40aLHjwalgRxJsqTJkwU7olzJMqHKljBjypw58yVK
mzQX4tSZ8+POnkCDCh1KFOTPoiOPIl3KtGJMpTVPQhWqUmRTolMPWr3KFWbWlV+7ih1LtmxKpGHJ
bnWYFuVaowbbmp3r0ifdqHcfys3b8C1fthf/ajS5d6/gw0MNI26ZVfHioI4fS55MmXHly4T1Yt4M
ODDnhh39No382SNpvqdLq+a4+hpOnKJbd5Y9+Whq2qpvJ/6rm2LvoqR/O70r/HFxhbFxJxSt+7Vy
y8+lRp8O9Dj16wKtl9aO/eZh7t0FJkIPXxY8+fPmz2tWP7p3evZkv76Hnz3p3Pn08+tH7xm6RfwH
WQcgW+CNx5WB+wFH3GgJNtjXVQM6uJqAmKUWIU8aBQQAOw==

------_=_NextPart_001_01C7E0AD.0B18BAD4--
