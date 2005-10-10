Return-Path: <markc@mail.com>
Message-ID: <003d01c5cd97$34404470$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "apoorv sangal" <apoorvsangal@gmail.com>,
	<Linuxppc-embedded@ozlabs.org>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com><20051007123126.GA6879@cathedrallabs.org>
	<a79669360510100340g2563b441w9418001c034dbe5b@mail.gmail.com>
Date: Mon, 10 Oct 2005 08:36:04 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003A_01C5CD75.A6B7FAB0"
Subject: Re: Problem Regarding Ping in Linux kernel version 2.4.24
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

------=_NextPart_000_003A_01C5CD75.A6B7FAB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



  Hi=20
  Thanks for the inputs... As per your suggestion I commented=20
                          { mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* =
autonegotiate */
  but it doesn't make any diffrence, still the ping doesn't worked.

  At Boot loader level (u-boot) Ping works fine,=20


  I think you need to provide more information, because there are many =
things
  that could be wrong.  Attach the output of your console from the boot =
sequence,
  and include the output of an ifconfig command if you can.

  Mark Chambers

------=_NextPart_000_003A_01C5CD75.A6B7FAB0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1515" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">&nbsp;</DIV>
  <DIV>Hi </DIV>
  <DIV>Thanks for the inputs... As per your suggestion I commented =
</DIV>
  =
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  &nbsp;{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate =
*/</DIV>
  <DIV>but it doesn't make any diffrence, still the ping doesn't =
worked.</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV>At Boot loader level (u-boot) Ping works fine, </DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I think you need to provide more =
information,=20
  because there are many things</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>that could be wrong.&nbsp; Attach the =
output of=20
  your console from the boot sequence,</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>and include the output of an ifconfig =
command if=20
  you can.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Mark Chambers</FONT></DIV>
  <DIV><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_003A_01C5CD75.A6B7FAB0--
