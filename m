Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 9B1EC67B6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 05:46:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E0D9.8C2B92CE"
Subject: RE: Console Stops on NFS root startup
Date: Mon, 25 Sep 2006 15:31:48 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B046ED0D2@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Clint Thomas" <cthomas@Soneticom.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6E0D9.8C2B92CE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Clint,

=20

Check your interrupt setup for the epic.  If something is wrong with the
uart interrupt configuration, you will stop seeing output after "Freeing
unused kernel memory".

=20

Scott

=20






___________________________________________________________________=20

  Scott N. Coulter=20
  Senior Software Engineer=20
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118=20
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com=20
  U.S.A.                        Web:    http://www.cyclone.com=20
___________________________________________________________________=20

________________________________

From: linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org]=

On Behalf Of Clint Thomas
Sent: Monday, September 25, 2006 3:29 PM
To: linuxppc-embedded@ozlabs.org
Subject: Console Stops on NFS root startup

=20

Hey guys,

I have a dev board based loosely off the MPC8540ADS that I am trying to
boot over NFS. After setting up the proper kernel configuration and
sharing the root filesystem over NFS, I boot up the board. Everything
loads up fine, and it even says it mounts the root filesystem, however
this is the output I get.

IP-Config: Complete:
      device=3Deth0, addr=3D204.215.226.251, mask=3D255.255.255.0,
gw=3D204.215.226.50,
     host=3D204.215.226.251, domain=3D, nis-domain=3D(none),
     bootserver=3D204.215.226.250, rootserver=3D204.215.226.250, =
rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 204.215.226.250
Looking up port of RPC 100005/1 on 204.215.226.250
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 236k init

=20

At this point, the serial console no longer displays or accepts input
from the keyboard. The system does not appear to hang, because when I
try to ping it from another point on the network, it responds. It seems
like either init is not executing at this point, or if the console is
being changed to another device. I wanted to know if anybody has had
this problem before. I tried building BusyBox as a static-linked binary,
which has not resolved the issue. I have also tried multiple root file
system builds, which has also not yielded a solution. Thanks for any
assistance with this.

=20

Clinton Thomas

=20


------_=_NextPart_001_01C6E0D9.8C2B92CE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" =
name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Clint,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Check your interrupt setup for the =
epic. &nbsp;If
something is wrong with the uart interrupt configuration, you will stop =
seeing output
after &#8220;Freeing unused kernel =
memory&#8221;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Scott<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3 =
color=3Dnavy
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt;color:navy'><br>
<br>
<br>
<o:p></o:p></span></font></p>

<p><font size=3D2 color=3Dnavy face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:navy'>________________________________________________________=
___________</span></font><font
color=3Dnavy><span style=3D'color:navy'> <o:p></o:p></span></font></p>

<p><font size=3D2 color=3Dnavy face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>&nbsp; Scott N. =
Coulter</span></font><font
color=3Dnavy><span style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
Senior
Software Engineer</span></font><font color=3Dnavy><span =
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
</span></font><font
color=3Dnavy><span style=3D'color:navy'><br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
Cyclone
Microsystems&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font><font
color=3Dnavy><span style=3D'color:navy'><br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
370 James
Street&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
Phone:&nbsp; 203.786.5536 ext. 118</span></font><font color=3Dnavy><span
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
<st1:City
w:st=3D"on">New Haven</st1:City>, CT =
06513-3051&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Email:&nbsp; scott.coulter@cyclone.com</span></font><font =
color=3Dnavy><span
style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:navy'>&nbsp; =
<st1:country-region
w:st=3D"on"><st1:place =
w:st=3D"on">U.S.A.</st1:place></st1:country-region>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Web:&nbsp;&nbsp;&nbsp; <a =
href=3D"http://www.cyclone.com">http://www.cyclone.com</a></span></font><=
font
color=3Dnavy><span style=3D'color:navy'> <br>
</span></font><font size=3D2 color=3Dnavy face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>________________________________________________________=
___________</span></font><font
color=3Dnavy><span style=3D'color:navy'> </span></font><o:p></o:p></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org]=
 <b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Clint Thomas<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Monday, September =
25, 2006
3:29 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linuxppc-embedded@ozlabs.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Console Stops on =
NFS root
startup</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hey guys,<br>
<br>
I have a dev board based loosely off the MPC8540ADS that I am trying to =
boot
over NFS. After setting up the proper kernel configuration and sharing =
the root
filesystem over NFS, I boot up the board. Everything loads up fine, and =
it even
says it mounts the root filesystem, however this is the output I =
get.<br>
<br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>IP-Config: =
Complete:</span></font></i></em><i><span
style=3D'font-style:italic'><br>
<em><i><font face=3DArial><span =
style=3D'font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device=3Deth0, addr=3D204.215.226.251, mask=3D255.255.255.0, =
gw=3D204.215.226.50,</span></font></i></em><br>
<em><i><font face=3DArial><span =
style=3D'font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;
host=3D204.215.226.251, domain=3D, =
nis-domain=3D(none),</span></font></i></em><br>
<em><i><font face=3DArial><span =
style=3D'font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;
bootserver=3D204.215.226.250, rootserver=3D204.215.226.250, =
rootpath=3D</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>NET4: Unix =
domain
sockets 1.0/SMP for Linux NET4.0.</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>Looking up =
<st1:place
w:st=3D"on"><st1:PlaceType w:st=3D"on">port</st1:PlaceType> of =
<st1:PlaceName
 w:st=3D"on">RPC</st1:PlaceName></st1:place> 100003/2 on =
204.215.226.250</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>Looking up =
<st1:place
w:st=3D"on"><st1:PlaceType w:st=3D"on">port</st1:PlaceType> of =
<st1:PlaceName
 w:st=3D"on">RPC</st1:PlaceName></st1:place> 100005/1 on =
204.215.226.250</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>VFS: Mounted =
root (nfs
filesystem).</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>Mounted =
devfs on /dev</span></font></i></em><br>
<em><i><font face=3DArial><span style=3D'font-family:Arial'>Freeing =
unused kernel
memory: 236k =
init</span></font></i></em></span></i></span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>At this point, the serial console no longer displays =
or
accepts input from the keyboard. The system does not appear to hang, =
because
when I try to ping it from another point on the network, it responds. It =
seems
like either init is not executing at this point, or if the console is =
being
changed to another device. I wanted to know if anybody has had this =
problem
before. I tried building BusyBox as a static-linked binary, which has =
not
resolved the issue. I have also tried multiple root file system builds, =
which
has also not yielded a solution. Thanks for any assistance with =
this.</span></font><o:p></o:p></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><st1:City w:st=3D"on"><st1:place w:st=3D"on"><font =
size=3D2
  face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Clinton</span></font></st1:p=
lace></st1:City><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> =
Thomas</span></font><o:p></o:p></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C6E0D9.8C2B92CE--
