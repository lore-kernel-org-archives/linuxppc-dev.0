Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id 720A0DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 10:04:33 +1000 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id l6304V4n001780
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 Jul 2007 17:04:31 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com
	[171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id l6304Tmq012536
	for <linuxppc-embedded@ozlabs.org>; Tue, 3 Jul 2007 00:04:29 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7BD05.B9912249"
Subject: help on dts compiler please.
Date: Mon, 2 Jul 2007 17:04:28 -0700
Message-ID: <F795765B112E7344AF36AA911279641502D1A454@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C7BD05.B9912249
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=20
I have downloaded the latest Linux code from the following git tree:
git:// git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
=20
I have also installed dtc compiler version.
I am trying to create dtb file from mpc8541cds.dts.
I ran the following command and get error:
=20
$ dtc -f -I dts -O dtb mpc8541cds.dts
DTC: dts->dtb  on file "mpc8541cds.dts"
syntax error at line 15
FATAL ERROR: Couldn't read input tree

=20
Many thanks in advance,
Bizhan

------_=_NextPart_001_01C7BD05.B9912249
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007>Hi=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007>I have =
downloaded=20
the latest Linux code from the following git tree:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D386375723-02072007></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D386375723-02072007><FONT =
size=3D2>git://=20
git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git</FONT></SPAN><=
/FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007><FONT=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007><FONT =
size=3D2>I have=20
also installed dtc compiler version.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007><FONT =
size=3D2>I am=20
trying to create dtb file from =
mpc8541cds.dts.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D386375723-02072007><FONT =
size=3D2>I ran=20
the following command and get error:</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D386375723-02072007></SPAN></FONT><FONT><SPAN=20
class=3D386375723-02072007>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>$ dtc -f -I dts -O dtb =
mpc8541cds.dts<BR>DTC:=20
dts-&gt;dtb&nbsp; on file "mpc8541cds.dts"<BR>syntax error at line =
15<BR>FATAL=20
ERROR: Couldn't read input tree<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D386375723-02072007><FONT face=3DArial size=3D2>Many =
thanks in=20
advance,</FONT></SPAN></DIV>
<DIV><SPAN class=3D386375723-02072007><FONT face=3DArial=20
size=3D2>Bizhan</FONT></SPAN></DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C7BD05.B9912249--
