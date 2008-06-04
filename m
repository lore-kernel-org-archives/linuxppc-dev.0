Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s2.bay0.hotmail.com (bay0-omc2-s2.bay0.hotmail.com
	[65.54.246.138]) by ozlabs.org (Postfix) with ESMTP id ED057DDF78
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 00:43:49 +1000 (EST)
Message-ID: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_085e05ad-0c85-4a84-944b-00112108744b_"
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: FP and signal 4
Date: Wed, 4 Jun 2008 14:43:48 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_085e05ad-0c85-4a84-944b-00112108744b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all,

Has anyone come across any floating point issues in the new powerpc kernel =
branch with regards to 44x? I'm seeing programs (i.e. init/busybox) generat=
ing signal 4 (illegal instruction) exceptions. If I compile a 2.6.25 kernel=
 with the CONFIG_MATH_EMULATION option set, then everything works OK.=20

Using a 440EPx (has a onchip FPU) with the ELDK 4.0 ppc_4xxFP toolchain for=
 all apps/kernel/fs.=20

Kind of follows on from this thread: http://ozlabs.org/pipermail/linuxppc-e=
mbedded/2007-June/027363.html


 Regards
   Jan

_________________________________________________________________

http://clk.atdmt.com/UKM/go/msnnkmgl0010000009ukm/direct/01/=

--_085e05ad-0c85-4a84-944b-00112108744b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Hi all,<br><br>Has anyone come across any floating point issues in the new =
powerpc kernel branch with regards to 44x? I'm seeing programs (i.e. init/b=
usybox) generating signal 4 (illegal instruction) exceptions. If I compile =
a 2.6.25 kernel with the CONFIG_MATH_EMULATION option set, then everything =
works OK. <br><br>Using a 440EPx (has a onchip FPU) with the ELDK 4.0 ppc_4=
xxFP toolchain for all apps/kernel/fs. <br><br>Kind of follows on from this=
 thread: http://ozlabs.org/pipermail/linuxppc-embedded/2007-June/027363.htm=
l<br><br><br>&nbsp;Regards<br>&nbsp;&nbsp; Jan<br><br /><hr />Get fish-slap=
ping on Messenger! <a href=3D'http://clk.atdmt.com/UKM/go/msnnkmgl001000000=
8ukm/direct/01/' target=3D'_new'>Play Now</a></body>
</html>=

--_085e05ad-0c85-4a84-944b-00112108744b_--
