Return-Path: <CKuffner@LIO.AACISD.com>
Received: from mail.aacisd.com (mail.aacisd.com [63.165.50.170])
	by ozlabs.org (Postfix) with SMTP id 747CA67BB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Sep 2006 03:13:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D368.5B032F04"
Subject: I2C on MPC8272...
Date: Fri, 8 Sep 2006 13:00:58 -0400
Message-ID: <BE8B3EECA608414FB163FBA4576FCEBD432009@EXNY.us.corp.aacisd.com>
From: "Kuffner Cory" <CKuffner@LIO.AACISD.com>
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

------_=_NextPart_001_01C6D368.5B032F04
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,
=20
Does anyone know how to use the I2C module for the MPC8272??  We are =
attempting to enable it by following code written for a bareboard system =
and converting it into a kernel module (2.6.11 Kernel), but nothing =
happens on our SDA and SCL data lines.  The parameter ram is kind of =
tricky to set up, but I beleive we have everything pointing where it =
should.  To write to the IMM we are using the ioremap function with =
ioread and iowrite, we can write to the ports so I don't think there is =
an issue writing to memory, but I'm new to embedded linux.  Has anyone =
ever used the I2C controller in one of freescale's chips or just a good =
understanding of I2C modules in embedded linux??  I think all the chips =
have the same I2C interface....so it should be the same set up for =
MPC8250, 8255, 8260, etc.
=20
Thanks,
=20
Cory Kuffner

------_=_NextPart_001_01C6D368.5B032F04
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY>=0A=
<DIV id=3DidOWAReplyText61603 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello =
all,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Does anyone =
know how to use =0A=
the I2C module for the MPC8272??&nbsp; We are attempting to enable it by =0A=
following code written for a bareboard system and converting it into a =
kernel =0A=
module (2.6.11 Kernel), but nothing happens on our SDA and SCL data =
lines.&nbsp; =0A=
The parameter ram is kind of tricky to set up, but I beleive we have =
everything =0A=
pointing where it should.&nbsp; To write to the IMM we are using the =
ioremap =0A=
function with ioread and iowrite, we can write to the ports so I don't =
think =0A=
there is an issue writing to memory, but I'm new to embedded =
linux.&nbsp; Has =0A=
anyone ever used the I2C&nbsp;controller in one of freescale's chips or =
just a =0A=
good understanding of I2C modules in embedded linux??&nbsp; I =
think&nbsp;all the =0A=
chips&nbsp;have the same I2C interface....so it should be the same set =
up for =0A=
MPC8250, 8255, 8260, etc.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>=0A=
<DIV id=3DidSignature76132 dir=3Dltr>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV id=3DidSignature53576 dir=3Dltr>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV id=3DidSignature56309 dir=3Dltr>=0A=
<DIV>Cory =0A=
Kuffner</DIV></DIV></FONT></DIV></DIV></FONT></DIV></DIV></BODY></HTML>
------_=_NextPart_001_01C6D368.5B032F04--
