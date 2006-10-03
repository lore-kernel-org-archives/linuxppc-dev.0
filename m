Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 09E9B67C04
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Oct 2006 19:05:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E6CB.074B95BA"
Subject: RE:  Kerenl OOPS on insertion of driver module
Date: Tue, 3 Oct 2006 05:04:22 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F65AB@sbsserver.AlphionCorp.local>
References: <8584FDC94AFF7640B17B8A89B23B19B34F659F@sbsserver.AlphionCorp.local>
	<8584FDC94AFF7640B17B8A89B23B19B34F65A1@sbsserver.AlphionCorp.local>
	<8584FDC94AFF7640B17B8A89B23B19B34F65A8@sbsserver.AlphionCorp.local>
From: "Sachin Rane" <SRane@alphion.com>
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

------_=_NextPart_001_01C6E6CB.074B95BA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
Please ignore my last mail.
The problem has been resolved.
=20
Thanks and Regards,
Sachin Rane

________________________________

From: Sachin Rane
Sent: Tue 10/3/2006 1:40 AM
To: linuxppc-embedded@ozlabs.org
Subject: Kerenl OOPS on insertion of driver module


Hi,
=20
I am trying to write an I2C EEPROM chip driver.
I am using MACC ppc440 evaluation board with Timesys Linux kernel =
2.6.16.
=20
I am getting an Kernel OOPS on insertion of the driver code.
=20
Could you help me to find out the reason?
I have attached the Kernel Oops Log, Driver code, makefile and =
System.map file for a reference.
=20
=20
Regards,
Sachin Rane
=20

------_=_NextPart_001_01C6E6CB.074B95BA
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText43524 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Hi,</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Please ignore =
my last mail.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>The problem </FONT><FONT =
face=3DArial size=3D2>has been resolved.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks and =
Regards,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Sachin Rane</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Sachin Rane<BR><B>Sent:</B> =
Tue 10/3/2006 1:40 AM<BR><B>To:</B> =
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Kerenl OOPS on insertion =
of driver module<BR></FONT><BR></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV id=3DidOWAReplyText71550 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Hi,</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV dir=3Dltr>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am trying to write an I2C EEPROM chip =
driver.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am using MACC ppc440 evaluation board =
with Timesys Linux kernel 2.6.16.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am getting an Kernel OOPS on =
insertion of the driver code.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Could you help me to find out the =
reason?</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I have attached the Kernel Oops Log, =
Driver code, makefile&nbsp;and System.map file for a =
reference.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Sachin Rane</FONT></DIV>=0A=
<DIV><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV></DIV></DIV></DIV></BODY></HTML>
------_=_NextPart_001_01C6E6CB.074B95BA--
