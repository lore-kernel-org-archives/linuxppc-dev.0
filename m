Return-Path: <marko.vaupotic@iskrasistemi.si>
Received: from mercury.iskratr.si (mercury.iskratr.si [193.201.45.54])
	by ozlabs.org (Postfix) with ESMTP id 06FFCDDF45
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 19:08:01 +1100 (EST)
Received: from localhost (mercury.iskratr.si [127.0.0.1])
	by mercury.iskratr.si (Postfix) with ESMTP id 544CB33C91F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 08:50:51 +0100 (CET)
Received: from mercury.iskratr.si ([127.0.0.1])
	by localhost (mercury.iskratr.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fdhd7czxHiyD for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 08:50:50 +0100 (CET)
Received: from vavpoticmarko (unknown [10.12.14.51])
	by mercury.iskratr.si (Postfix) with ESMTP id 7FF1233C919
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 08:50:50 +0100 (CET)
From: "Vaupotic Marko" <marko.vaupotic@iskrasistemi.si>
To: <linuxppc-embedded@ozlabs.org>
Subject: I2C device node on Sequoia (440EPx)
Date: Tue, 11 Mar 2008 08:50:52 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0034_01C88355.02B67570"
Message-Id: <20080311075050.7FF1233C919@mercury.iskratr.si>
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

------=_NextPart_000_0034_01C88355.02B67570
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit


Hi

I am using an AMCC 440EPx processor on "Sequoia" board with Linux 2.6.21
rc4. I am trying to use the i2c in the user-space
In my Linux config file (Sequoia default) I have:
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

I than added the "i2c-0" device in /dev (# mknod i2c-0 c 89 0)
When I run a simple program to open the device (provided by the
"dev-interface" file of i2c kernel documentation) it returns errno message:
"No such device".

I have tried to use the device number 1, 2, 3, 4 but with no luck.

Any suggestions what I  might be doing wrong?

Best Regards

Marko




------=_NextPart_000_0034_01C88355.02B67570
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>I2C device node on Sequoia (440EPx)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi<BR>
<BR>
I am using an AMCC 440EPx processor on &quot;Sequoia&quot; board with =
Linux 2.6.21 rc4. I am trying to use the i2c in the =
user-space</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">In my Linux config =
file (Sequoia default)</FONT></SPAN><SPAN LANG=3D"sl"> <FONT SIZE=3D2 =
FACE=3D"Arial CE">I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> have:<BR>
CONFIG_I2C=3Dy<BR>
CONFIG_I2C_CHARDEV=3Dy<BR>
<BR>
I than added the &quot;i2c-0&quot; device in /dev (# mknod i2c-0 c 89 =
0)<BR>
When I run a simple program to open the device (provided by the =
&quot;dev-interface&quot; file of i2c kernel documentation) it returns =
errno message: &quot;No such device&quot;.<BR>
<BR>
I have tried to use the device number 1, 2, 3, 4 but with no luck.<BR>
<BR>
Any suggestions what I&nbsp; might be doing wrong?<BR>
<BR>
Best Regards<BR>
<BR>
Marko</FONT></SPAN>
</P>
<BR>
<BR>

</BODY>
</HTML>
------=_NextPart_000_0034_01C88355.02B67570--
