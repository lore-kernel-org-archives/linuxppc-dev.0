Return-Path: <ncaruso@irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id A256E67A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 08:33:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C513A5.F9775F32"
Date: Tue, 15 Feb 2005 16:33:22 -0500
Message-ID: <712A2DEC228C7448978CBD7A7AD5B090592CE2@fever.wardrobe.irobot.com>
From: "Caruso, Nick" <ncaruso@irobot.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: How to set a custom baud rate using 2.6 linux distro on MPC5200
	based board?
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

------_=_NextPart_001_01C513A5.F9775F32
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm trying to set a custom baud rate (500KBaud, in case anyone cares) on =
one of the PSCs on a MPC5200 board.
The PSC is configured as a serial port and is visible and usable under =
the 2.6 kernel we're using.

I used to use the following code under 2.4 on an x86 board:

   serial_info.flags =3D ASYNC_SPD_CUST | ASYNC_LOW_LATENCY;
   serial_info.custom_divisor =3D 48;  // clock on FTDI chip / 48 =3D=3D =
500KB

   if ( ioctl(tty_fd, TIOCSSERIAL, &serial_info ) < 0) {
     perror("config_serial_port: ioctl TIOCSSERIAL");
     return(-1);
   }

This compiled fine under the ppc cross-dev tools we have but it fails =
with an "invalid argument" error when run on the ppc board.

I'm busy reading the driver sources but thought someone on the list =
might be able to help me out.

  thanks!
     --nick caruso
       irobot corporation
       intelligent vehicles
       r-gator project

------_=_NextPart_001_01C513A5.F9775F32
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>How to set a custom baud rate using 2.6 linux distro on MPC5200 =
based board?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I'm trying to set a custom baud rate (500KBaud, in =
case anyone cares) on one of the PSCs on a MPC5200 board.<BR>
The PSC is configured as a serial port and is visible and usable under =
the 2.6 kernel we're using.<BR>
<BR>
I used to use the following code under 2.4 on an x86 board:<BR>
<BR>
&nbsp;&nbsp; serial_info.flags =3D ASYNC_SPD_CUST | =
ASYNC_LOW_LATENCY;<BR>
&nbsp;&nbsp; serial_info.custom_divisor =3D 48;&nbsp; // clock on FTDI =
chip / 48 =3D=3D 500KB<BR>
<BR>
&nbsp;&nbsp; if ( ioctl(tty_fd, TIOCSSERIAL, &amp;serial_info ) &lt; 0) =
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp; perror(&quot;config_serial_port: ioctl =
TIOCSSERIAL&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp; return(-1);<BR>
&nbsp;&nbsp; }<BR>
<BR>
This compiled fine under the ppc cross-dev tools we have but it fails =
with an &quot;invalid argument&quot; error when run on the ppc =
board.<BR>
<BR>
I'm busy reading the driver sources but thought someone on the list =
might be able to help me out.<BR>
<BR>
&nbsp; thanks!<BR>
&nbsp;&nbsp;&nbsp;&nbsp; --nick caruso<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irobot corporation<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intelligent vehicles<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-gator project</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C513A5.F9775F32--
