Return-Path: <Bjorn.Ostby@combitechsystems.com>
Received: from ms-102.aerotechtelub.se (ms-102.aerotechtelub.se
	[192.176.33.164]) by ozlabs.org (Postfix) with ESMTP id C553867A7E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Feb 2005 22:19:37 +1100 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-102.aerotechtelub.se (Clearswift SMTPRS 5.0.4) with ESMTP id
	<T6efe4882d6c0b021a11254@ms-102.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Tue, 8 Feb 2005 12:09:27 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C50DCE.9BB1F0D7"
Date: Tue, 8 Feb 2005 12:09:07 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CBE7@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RTAI+ELDK Compile Problems
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

------_=_NextPart_001_01C50DCE.9BB1F0D7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've got a major problem trying to compile RTAI using the ELDK cross =
compiler.
I'm using ELDK version 3.1, and my target is ppc_8xx (823). I have =
followed the instructions given at =
ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install, using the
linuxppc_2_4_devel kernel (2004_04_30_1320) and rtai-24.1.12-denx.=20

Now, the rtai patch works fine, and the kernel compiles, but when I try =
to compile rtai
The following error occurs:

/opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:=20
In function `rtai_srq':
/opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:32:=20
error: asm-specifier for variable `__sc_3' conflicts with asm clobber =
list

I have also tried other versions of rtai (3.0 and 3.1) but these give =
the same result.

I may also mention that when trying to compile any kernel except the one =
shipped with eldk and ppc_devel label_2004_04_30_1320, similar errors =
occur:

compile example from ppc_2_4_devel (label_2003_10_11_0005)=20
using "make ARCH=3Dppc CROSS_COMPILE=3Dppc_8xx- uImage"

/opt/eldk-3.1/ppc_8xx/usr/src/linuxppc_2_4_devel/include/asm/unistd.h: =
In function `init':
/opt/eldk-3.1/ppc_8xx/usr/src/linuxppc_2_4_devel/include/asm/unistd.h:439=
: error: asm-specifier for variable `__sc_4' conflicts with asm clobber =
list

I have exported the CROSS_COMPILE variable and added the =
eldk-3.1/usr/bin and eldk-3.1/bin
directories to the path.

Can anyone tell me what's going on here or, better yet, how to solve =
it?.


Best regards,
Bjorn Ostby



------_=_NextPart_001_01C50DCE.9BB1F0D7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>RTAI+ELDK Compile Problems</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">I've got a major problem trying =
to compile RTAI using the ELDK cross compiler.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I'm using ELDK version 3.1, and =
my target is ppc_8xx (823). I have followed the instructions given at =
</FONT><A =
HREF=3D"ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install</FONT></U></A><FON=
T SIZE=3D2 FACE=3D"Courier New">, using the</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">linuxppc_2_4_devel kernel =
(2004_04_30_1320) and rtai-24.1.12-denx. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Now, the rtai patch works fine, =
and the kernel compiles, but when I try to compile rtai</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">The following error =
occurs:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">/opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h: =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">In function `rtai_srq':</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">/opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:32=
: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">error: asm-specifier for =
variable `__sc_3' conflicts with asm clobber list</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I have also tried other versions =
of rtai (3.0 and 3.1) but these give the same result.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I may also mention that when =
trying to compile any kernel except the one shipped with eldk and =
ppc_devel label_2004_04_30_1320, similar errors occur:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">compile example from =
ppc_2_4_devel (label_2003_10_11_0005) </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">using &quot;make ARCH=3Dppc =
CROSS_COMPILE=3Dppc_8xx- uImage&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">/opt/eldk-3.1/ppc_8xx/usr/src/linuxppc_2_4_devel/include/asm/unistd.=
h: In function `init':</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">/opt/eldk-3.1/ppc_8xx/usr/src/linuxppc_2_4_devel/include/asm/unistd.=
h:439: error: asm-specifier for variable `__sc_4' conflicts with asm =
clobber list</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I have exported the CROSS_COMPILE =
variable and added the eldk-3.1/usr/bin and eldk-3.1/bin</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">directories to the path.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Can anyone tell me what's going =
on here or, better yet, how to solve it?.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Best regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Bjorn Ostby</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C50DCE.9BB1F0D7--
