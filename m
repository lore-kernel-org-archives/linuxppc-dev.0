Return-Path: <lagrange@fr.oleane.com>
Received: from smtp04.msg.oleane.net (smtp04.msg.oleane.net [62.161.4.4])
	by ozlabs.org (Postfix) with ESMTP id 784B5DDFE1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 01:46:02 +1000 (EST)
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp04.msg.oleane.net (MTA) with ESMTP id l5BFKkP6029675
	for <linuxppc-embedded@ozlabs.org>; Mon, 11 Jun 2007 17:20:47 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux 2.6.x, MTD drivers and NAND flashes
Date: Mon, 11 Jun 2007 17:20:43 +0200
Message-ID: <000001c7ac3c$15e7da80$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C7AC4C.D972F470"
In-Reply-To: 
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

------=_NextPart_000_0001_01C7AC4C.D972F470
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I use a Linux 2.6.9 on a 85xx custom board with a NAND flash.

This flash has some bad blocks.
NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V
8-bit)
Scanning device for bad blocks
Bad eraseblock 8 at 0x00100000
Bad eraseblock 430 at 0x035c0000
...
Creating 1 MTD partitions on "NAND 128MiB 3,3V 8-bit":
0x00000000-0x08000000 : "flash partition 1".

I have selected in the kernel :
1) the MTD character and block supports for NAND,
2) the CRAMFS and JFFS2 supports for NAND.

I can erase the flash but receive IO errors for each bad blocks (that seems
right).
I can mount an empty JFFS2 partition on the NAND and untar some directories
and files in it.

I would like to generate some JFFS2 images and program them in the flash
with a character
command like "cat img > /dev/mtd/0". If I dont encounter a bad block, it
runs right else the
command fails.

This is a little bit annoying. So my question is simple :
Is there a MTD character driver which can detect and ignore the bad blocks
in a NAND flash ?

Thanks for any tips.
Bye
Laurent




------=_NextPart_000_0001_01C7AC4C.D972F470
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE></TITLE>

<META content=3D"MSHTML 6.00.6000.16441" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>Hello,<BR><BR>I use a Linux 2.6.9 on a =
85xx custom=20
board with a NAND flash. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This flash has some bad =
blocks.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>NAND device: Manufacturer ID: 0xec, =
Chip ID: 0xf1=20
(Samsung NAND 128MiB 3,3V 8-bit)<BR>Scanning device for bad =
blocks<BR>Bad=20
eraseblock 8 at 0x00100000<BR>Bad eraseblock 430 at =
0x035c0000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>...<BR>Creating 1 MTD partitions on =
"NAND 128MiB=20
3,3V 8-bit":<BR>0x00000000-0x08000000 : "flash partition =
1".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have selected in the kernel =
:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>1) the MTD character and block supports =
for=20
NAND,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>2) the CRAMFS and JFFS2 supports for=20
NAND.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I can erase the flash but receive IO =
errors for=20
each bad blocks (that seems right).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I can mount an empty JFFS2 partition on =
the NAND=20
and untar some directories and files in it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would like to generate some JFFS2 =
images and=20
program them in the flash </FONT><FONT face=3DArial size=3D2>with a =
character=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>command like "cat img &gt; /dev/mtd/0". =

</FONT><FONT face=3DArial size=3D2>If I dont encounter a bad block, it =
runs=20
right&nbsp;else the </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>command fails. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This is a little bit annoying. So =
m</FONT><FONT=20
face=3DArial size=3D2>y question is simple : </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Is there a MTD character driver which =
can detect=20
and ignore the bad blocks in a NAND flash&nbsp;?&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks for any tips.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Bye</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Laurent</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial><BR><FONT =
size=3D2></FONT></FONT></DIV></FONT></BODY></HTML>

------=_NextPart_000_0001_01C7AC4C.D972F470--
