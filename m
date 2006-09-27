Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 0954B67B9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 00:12:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E23F.01E53194"
Subject: RE: Need help to write I2C EEPROM device driver
Date: Wed, 27 Sep 2006 10:11:52 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F6593@sbsserver.AlphionCorp.local>
References: <8584FDC94AFF7640B17B8A89B23B19B34F658F@sbsserver.AlphionCorp.local>
	<200609271221.54878.matthias.fuchs@esd-electronics.com>
From: "Sachin Rane" <SRane@alphion.com>
To: "Matthias Fuchs" <matthias.fuchs@esd-electronics.com>,
	<linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6E23F.01E53194
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,
=20
Thanks for reply.
=20
To access EEPROM using /dev/i2c-<x>, which drivers I need to load?
=20
Please confirm that I need to load following drivers:
1. i2c-core.ko (Core Driver)
2. i2c-ibm-iic.ko (Bus Driver)
3. i2c-dev.ko (Dev Interface driver)
=20
Do I need to load 'eeprom.ko'?
Because in one of the mail from the mailing list, it was mentioned that =
I should not load  ''eeprom.ko" to access the chip using 'dev' =
interface.
=20
Thanks and Regards,
Sachin Rane

________________________________

From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
Sent: Wed 9/27/2006 6:21 AM
To: linuxppc-embedded@ozlabs.org
Cc: Sachin Rane
Subject: Re: Need help to write I2C EEPROM device driver



Hi Sachin,

there is already a driver for this part in the kernel
(drivers/i2c/chips/eeprom.c).

BTW: to do some simple reads and writes to an I2C EEPROM it is very =
simple to
access the EEPROM via read/write/ioctl through /dev/i2c-<x>. No driver - =
only
userland code.

Matthias


On Tuesday 26 September 2006 16:34, Sachin Rane wrote:
> Hi,
>=20
> I am looking for an information to write a device driver to access =
EEPROM IC
M24C02-WBN6.
> The EEPROM IC M24C02-WBN is present on the 'ppc440' evaluation board =
for
boot strap purpose.



------_=_NextPart_001_01C6E23F.01E53194
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: Need help to write I2C EEPROM device =
driver</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText13813 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV id=3DidOWAReplyText67499 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hi <FONT =
face=3DTahoma>Matthias</FONT>,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks for reply.</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>To access =
EEPROM using <FONT face=3D"Times New Roman">/dev/i2c-&lt;x&gt;</FONT>, =
which drivers I need to load?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Please confirm that I need to =
load following drivers:</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>1. i2c-core.ko (Core =
Driver)</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>2. i2c-ibm-iic.ko (Bus =
Driver)</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>3. i2c-dev.ko (Dev Interface driver)</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Do I need to load 'eeprom.ko'?</DIV>=0A=
<DIV dir=3Dltr>Because in one of the mail from the mailing list, it was =
mentioned that I should not&nbsp;load&nbsp;&nbsp;''eeprom.ko" =
to&nbsp;access the chip&nbsp;using 'dev'&nbsp;interface.</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Thanks and Regards,</DIV>=0A=
<DIV dir=3Dltr>Sachin Rane</DIV></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Matthias Fuchs =
[mailto:matthias.fuchs@esd-electronics.com]<BR><B>Sent:</B> Wed =
9/27/2006 6:21 AM<BR><B>To:</B> =
linuxppc-embedded@ozlabs.org<BR><B>Cc:</B> Sachin =
Rane<BR><B>Subject:</B> Re: Need help to write I2C EEPROM device =
driver<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Hi Sachin,<BR><BR>there is already a driver for this =
part in the kernel<BR>(drivers/i2c/chips/eeprom.c).<BR><BR>BTW: to do =
some simple reads and writes to an I2C EEPROM it is very simple =
to<BR>access the EEPROM via read/write/ioctl through /dev/i2c-&lt;x&gt;. =
No driver - only<BR>userland code.<BR><BR>Matthias<BR><BR><BR>On Tuesday =
26 September 2006 16:34, Sachin Rane wrote:<BR>&gt; =
Hi,<BR>&gt;&nbsp;<BR>&gt; I am looking for an information to write a =
device driver to access EEPROM IC<BR>M24C02-WBN6.<BR>&gt; The EEPROM IC =
M24C02-WBN is present on the 'ppc440' evaluation board for<BR>boot strap =
purpose.<BR></FONT></P></DIV></BODY></HTML>
------_=_NextPart_001_01C6E23F.01E53194--
