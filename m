Return-Path: <santhoshunnikrishnan@tataelxsi.co.in>
Received: from vsnlchnsym02.vsnlxchange.com (VSNLCHNSYM02.vsnlxchange.com
	[59.163.96.4]) by ozlabs.org (Postfix) with ESMTP id ED951DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 19:45:52 +1100 (EST)
Received: from vsnlchnsym02.vsnlxchange.com (unknown [127.0.0.1])
	by vsnlchnsym02.vsnlxchange.com (Symantec Mail Security) with ESMTP id
	E02251BD1 for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 13:59:41 +0530 (IST)
From: <santhoshunnikrishnan@tataelxsi.co.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: uImage getting changed each time when kernel build
Date: Thu, 16 Oct 2008 13:50:22 +0530
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_029B_01C92F96.22996D50"
Message-ID: <VSNLCHNFE002GXn5olX00012f98@VSNLCHNFE002.VSNLXCHANGE.COM>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_029B_01C92F96.22996D50
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_029C_01C92F96.229BDE50"


------=_NextPart_001_029C_01C92F96.229BDE50
Content-Type: text/plain;
	charset="us-ascii"
content-transfer-encoding: 7bit

Hi ,

I am working on SH4 architecture. I observed one strange thing. Each time i
build my kernel image (uImage) the last 10% of the uImage content is
changing. I compared uImages using diff command and with Beyond Compare
tool, which i did using binary as well as rule based comparison with time
stamp comparison disabled. I observed that every time when i build the
kernel image the lower 10% of the uImage differ from the previously build
uImage (build with in 20 min before the last one). Can any one help me to
know the reason behind this behavior? I want to know more about the format
of uImage and what exactly the lower 10% contains? i searched in various
sites and referred the documentation of U-boot. But i dint get the reason
for this behavior. I did the same comparison with vmlinux and vmlinux.bin
and i observed that each time i build these vmlinux and vimlinux.bin they
differ from the previous images (which i build 20 min before the last one )
by a max of 10 lines.
When i opened two vimlinux images (which i build with in a time gap of 20
min)using the readelf command. I observed that the last byte of some of the
address are different in the two vmlinux images. why it is so?
Please help me to understand this.

Thanks,
Santhosh
 
Regards,
Santhosh Unnikrishnan

 


The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments contained in it.

------=_NextPart_001_029C_01C92F96.229BDE50
Content-Type: text/html;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE id=3DridTitle>Blank</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<STYLE>BODY {
	MARGIN-TOP: 25px; FONT-SIZE: 10pt; MARGIN-LEFT: 25px; COLOR: #000000; FONT-=
FAMILY: Arial, Helvetica
}
P.msoNormal {
	MARGIN-TOP: 0px; FONT-SIZE: 10pt; MARGIN-LEFT: 0px; COLOR: #ffffcc; FONT-FA=
MILY: Helvetica, "Times New Roman"
}
LI.msoNormal {
	MARGIN-TOP: 0px; FONT-SIZE: 10pt; MARGIN-LEFT: 0px; COLOR: #ffffcc; FONT-FA=
MILY: Helvetica, "Times New Roman"
}
</STYLE>

<META content=3D"MSHTML 6.00.2900.3395" name=3DGENERATOR></HEAD>
<BODY id=3DridBody background=3Dcid:572381808@16102008-3459>
<DIV><FONT face=3D"Times New Roman"><FONT size=3D3>Hi ,<BR><BR>I am working=
 on SH4 
architecture. I observed one strange thing. Each time i build my kernel imag=
e 
(uImage) the last 10% of the uImage content is changing. I compared uImages=
 
using diff command and with Beyond Compare tool, which i did using binary as=
 
well as rule based comparison with time stamp comparison disabled. I observe=
d 
that every time when i build the kernel image the lower 10% of the uImage di=
ffer 
from the previously build uImage (build with in 20 min before the last one).=
 Can 
any one help me to know the reason behind this behavior? I want to know more=
 
about the format of uImage and what exactly the lower 10% contains? i search=
ed 
in various sites and referred the documentation of U-boot. But i dint get th=
e 
reason for this behavior. I did the same comparison with vmlinux and vmlinux=
.bin 
and i observed that each time i build these vmlinux and vimlinux.bin they di=
ffer 
from the previous images (which i build 20 min before the last one ) by a ma=
x of 
10 lines.<BR>When i opened two vimlinux images (which i build with in a time=
 gap 
of 20 min)using the readelf command. I observed that the last byte of some o=
f 
the address are different in the two vmlinux images. why it is so?<BR>Please=
 
help me to understand this.<BR><BR>Thanks,<BR>S<SPAN 
class=3D572381808-16102008>anthosh</SPAN></FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>Regards,</DIV>
<DIV align=3Dleft><STRONG>Santhosh Unnikrishnan</STRONG></DIV>
<P>&nbsp;</P><p>The information contained in this electronic message and any=
 attachments to this message are intended for the exclusive use of the addre=
ssee(s) and may contain proprietary, confidential or privileged information.=
 If you are not the intended recipient, you should not disseminate, distribu=
te or copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments contained in it.</p>
</BODY></HTML>

------=_NextPart_001_029C_01C92F96.229BDE50--

------=_NextPart_000_029B_01C92F96.22996D50
Content-Type: image/gif;
	name="Blank Bkgrd.gif"
Content-Transfer-Encoding: base64
Content-ID: <572381808@16102008-3459>

R0lGODlhLQAtAID/AP////f39ywAAAAALQAtAEACcAxup8vtvxKQsFon6d02898pGkgiYoCm6sq2
7iqWcmzOsmeXeA7uPJd5CYdD2g9oPF58ygqz+XhCG9JpJGmlYrPXGlfr/Yo/VW45e7amp2tou/lW
xo/zX513z+Vt+1n/tiX2pxP4NUhy2FM4xtjIUQAAOw==

------=_NextPart_000_029B_01C92F96.22996D50--
