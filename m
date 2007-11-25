Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8679ADDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 10:22:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82FB9.FAEE9482"
Subject: RE: SPI, I2C
Date: Sun, 25 Nov 2007 15:17:58 -0800
References: <4749441B.1000703@dlasys.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20071125232203.606C84F804E@mail91-cpk.bigfish.com>
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

------_=_NextPart_001_01C82FB9.FAEE9482
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


The drivers for these do exist (see git.xilinx.com).  I suppose as a =
'control' bus, they might actually be useful inside an FPGA, but why not =
just use dcr?  Part of the value of i2c is minimizing wires (including =
power wires), but that's hardly a design constraint in an FPGA compared =
to conserving logic.=20

I also got fed up with the i2c core at one point and wrote a bitbang =
version for the gpio.  It might be a bit slower, but it's dirt simple.  =
I can send it do you, if you're interested.

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of David H. Lynch Jr.
Sent: Sun 11/25/2007 1:44 AM
To: linuxppc-embedded
Subject: SPI, I2C
=20

    I have been asked to do SPI and I2C drivers for Pico cards.
  =20
    I am trying to grasp what the practical use of either could be in an
environment where neither SPI nor I2C are going to be able to
communicate outside the FPGA.

    I am guessing that SPI and I2C implementations already exist for
Xilinx FPGA's - any chance that drivers might already exist ?

    I would prefer not to charge a client to reinvent something that
exists, or that can not serve a useful purpose.

    I am not trying to imply that SPI or I2C are not useful, just that
they are communications channels, and unless  they have outside I2C or
SPI hardware to talk to what purpose might they serve ?



--=20
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too =
numerous to list.

"Any intelligent fool can make things bigger and more complex... It =
takes a touch of genius - and a lot of courage to move in the opposite =
direction."
Albert Einstein

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



------_=_NextPart_001_01C82FB9.FAEE9482
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: SPI, I2C</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>The drivers for these do exist (see =
git.xilinx.com).&nbsp; I suppose as a 'control' bus, they might actually =
be useful inside an FPGA, but why not just use dcr?&nbsp; Part of the =
value of i2c is minimizing wires (including power wires), but that's =
hardly a design constraint in an FPGA compared to conserving logic.<BR>
<BR>
I also got fed up with the i2c core at one point and wrote a bitbang =
version for the gpio.&nbsp; It might be a bit slower, but it's dirt =
simple.&nbsp; I can send it do you, if you're interested.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of David H. Lynch Jr.<BR>
Sent: Sun 11/25/2007 1:44 AM<BR>
To: linuxppc-embedded<BR>
Subject: SPI, I2C<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp; I have been asked to do SPI and I2C drivers for Pico =
cards.<BR>
&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp; I am trying to grasp what the practical use of either =
could be in an<BR>
environment where neither SPI nor I2C are going to be able to<BR>
communicate outside the FPGA.<BR>
<BR>
&nbsp;&nbsp;&nbsp; I am guessing that SPI and I2C implementations =
already exist for<BR>
Xilinx FPGA's - any chance that drivers might already exist ?<BR>
<BR>
&nbsp;&nbsp;&nbsp; I would prefer not to charge a client to reinvent =
something that<BR>
exists, or that can not serve a useful purpose.<BR>
<BR>
&nbsp;&nbsp;&nbsp; I am not trying to imply that SPI or I2C are not =
useful, just that<BR>
they are communications channels, and unless&nbsp; they have outside I2C =
or<BR>
SPI hardware to talk to what purpose might they serve ?<BR>
<BR>
<BR>
<BR>
--<BR>
Dave Lynch &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DLA Systems<BR>
Software Development:&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Embedded Linux<BR>
717.627.3770 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dhlii@dlasys.net &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <A =
HREF=3D"http://www.dlasys.net">http://www.dlasys.net</A><BR>
fax: 1.253.369.9244 &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cell: =
1.717.587.7774<BR>
Over 25 years' experience in platforms, languages, and technologies too =
numerous to list.<BR>
<BR>
&quot;Any intelligent fool can make things bigger and more complex... It =
takes a touch of genius - and a lot of courage to move in the opposite =
direction.&quot;<BR>
Albert Einstein<BR>
<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82FB9.FAEE9482--
