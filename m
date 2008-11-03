Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 30C13DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 04:50:02 +1100 (EST)
Subject: Trouble booting a v1 device tree on canyonlands
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C93DDC.97D52661"
Date: Mon, 3 Nov 2008 11:50:00 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F850@tanisys-ex2.Tanisys.Local>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C93DDC.97D52661
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am having trouble booting the canyonlands with the recent (10/31) denx
kernel tree and dts file.  I have mostly ruled out the kernel being
incorrect as it does work fine with the same uImage but an older version
(non-v1) device tree.  I pulled down the new code to get the new version
device tree, canyonlands.dts.  It compiles fine with a recent (11/1)
version of dtc but when the board goes to boot it gets to Loading
ramdisk ..OK and then hangs.  If I do nothing more than put an older
version of the device tree in (a pre v1), then it works fine. I do not
have anything attached to the board other than ethernet and a serial
port. =20
=20
Is there something special about the new version of the device tree file
that I need to massage to get this to work?  Do I need to install a
newer u-boot into the flash to handle this version of device tree?
=20
Thanks,
- ame



------_=_NextPart_001_01C93DDC.97D52661
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><FONT size=3D2>I am having trouble booting the =
canyonlands=20
with the recent<SPAN class=3D463034717-03112008> (10/31)</SPAN><SPAN=20
class=3D463034717-03112008>&nbsp;</SPAN>denx kernel tree and dts =
file.&nbsp; I=20
have mostly ruled out the<SPAN class=3D463034717-03112008> </SPAN>kernel =
being=20
incorrect as it does work fine with the same<SPAN =
class=3D463034717-03112008>=20
</SPAN>uImage but an older<SPAN class=3D463034717-03112008>=20
version</SPAN>&nbsp;<SPAN class=3D463034717-03112008>(non-v1) =
</SPAN>device=20
tree.&nbsp; I pulled down the new code<SPAN class=3D463034717-03112008> =
</SPAN>to=20
get the new version device tree, canyonlands.dts.&nbsp; It<SPAN=20
class=3D463034717-03112008> </SPAN>compiles fine with a recent (<SPAN=20
class=3D463034717-03112008>11/1</SPAN>) version of dtc but<SPAN=20
class=3D463034717-03112008> </SPAN>when the board goes to boot it gets =
to Loading=20
ramdisk ..OK<SPAN class=3D463034717-03112008> </SPAN>and then =
hangs.&nbsp; If I do=20
nothing more than put an older<SPAN class=3D463034717-03112008> =
</SPAN>version of=20
the device tree in<SPAN class=3D463034717-03112008> (a pre v1)</SPAN>, =
then it=20
works fine. I<SPAN class=3D463034717-03112008> </SPAN>do not<SPAN=20
class=3D463034717-03112008> </SPAN>have anything attached to the board =
other than=20
ethernet and<SPAN class=3D463034717-03112008> </SPAN>a serial port.<SPAN =

class=3D463034717-03112008>&nbsp; </SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D2><SPAN =
class=3D463034717-03112008></SPAN></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D463034717-03112008><FONT face=3DArial size=3D2>Is =
there something=20
special about the new version of the device tree file that I need to =
massage to=20
get this to work?&nbsp; Do I need to install a newer u-boot into the =
flash to=20
handle this version of device tree?</FONT></SPAN></DIV>
<DIV><SPAN class=3D463034717-03112008></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D463034717-03112008><FONT face=3DArial=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D463034717-03112008><FONT face=3DArial size=3D2>-=20
ame</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><BR><FONT =
size=3D2></FONT></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C93DDC.97D52661--
