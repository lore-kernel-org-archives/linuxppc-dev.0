Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 72E226885E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 23:01:32 +1100 (EST)
Message-ID: <004001c5f66f$70831a10$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>,
	<pritha.bhattacharya@tcs.com>
References: <OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Date: Thu, 1 Dec 2005 07:04:49 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003D_01C5F645.85484710"
Subject: Re: Linux hangs while Uncompressing
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

------=_NextPart_000_003D_01C5F645.85484710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All,=20

I have RAM version of U-Boot which is running on a board similar to =
MPC8260. My memory map isas follows:=20

Staring address                Device                Size                =
      Memory controller and CS=20

      0000 0000=20
      0800 0000=20
      FFF0 0000=20
      0F00 0000=20
      3000 0000=20
      3800 0000=20
      4200 0000=20
      5000 0000  FLASH (Boot)=20
      FLASH (Code)=20
      SSRAM=20
      CPU internal registers=20
      SDRAM=20
      SDRAM=20
      Framer=20
      DSP 8102  1MB (512Kx16)=20
      4 MB (1Mx16)=20
      2 MB (512Kx36)=20
      128 KB=20
      128 MB (16Mx72)=20
      128 MB (16Mx72)=20
      1 MB=20
      2 MB  BR0/OR0: CS0=20
      BR1/OR1: CS1=20
      BR2/OR2: CS2=20

      BR3/OR3: CS3=20
      BR4/OR4: CS4=20
      BR5/OR5: CS5=20
      BR6/OR6: CS6=20



This configuration will not work for linux.  Linux needs to run in SDRAM =
starting at zero (notice
'Load Address' and 'Entry Point' just before 'uncompressing image'.)

Mark Chambers
------=_NextPart_000_003D_01C5F645.85484710
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1522" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff><FONT face=3DArial size=3D2></FONT>
<DIV><BR><FONT face=3Dsans-serif size=3D2>Hi All,</FONT> <BR><BR><FONT=20
face=3Dsans-serif size=3D2>I have RAM version of U-Boot which is running =
on a board=20
similar to MPC8260. My memory map isas follows:</FONT> <BR><BR><FONT=20
face=3Dsans-serif size=3D2>Staring address &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;=20
&nbsp; &nbsp;Device &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;Size=20
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=20
&nbsp;Memory controller and CS</FONT> <BR></DIV>
<DIV>
<TABLE border=3D1>
  <TBODY>
  <TR vAlign=3Dtop>
    <TD><FONT face=3D"Times New Roman" size=3D2>0000 0000</FONT> =
<BR><FONT=20
      face=3D"Times New Roman" size=3D2>0800 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>FFF0 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>0F00 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>3000 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>3800 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>4200 0000</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>5000 0000</FONT>=20
    <TD><FONT face=3D"Times New Roman" size=3D2>FLASH (Boot)</FONT> =
<BR><FONT=20
      face=3D"Times New Roman" size=3D2>FLASH (Code)</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>SSRAM</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>CPU internal registers</FONT> =
<BR><FONT=20
      face=3D"Times New Roman" size=3D2>SDRAM</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>SDRAM</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>Framer</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>DSP 8102</FONT>=20
    <TD><FONT face=3D"Times New Roman" size=3D2>1MB (512Kx16)</FONT> =
<BR><FONT=20
      face=3D"Times New Roman" size=3D2>4 MB (1Mx16)</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>2 MB (512Kx36)</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>128 KB</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>128 MB (16Mx72)</FONT> <BR><FONT =

      face=3D"Times New Roman" size=3D2>128 MB (16Mx72)</FONT> <BR><FONT =

      face=3D"Times New Roman" size=3D2>1 MB</FONT> <BR><FONT =
face=3D"Times New Roman"=20
      size=3D2>2 MB</FONT>=20
    <TD><FONT face=3D"Times New Roman" size=3D2>BR0/OR0: CS0</FONT> =
<BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR1/OR1: CS1</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR2/OR2: CS2</FONT> =
<BR><BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR3/OR3: CS3</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR4/OR4: CS4</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR5/OR5: CS5</FONT> <BR><FONT=20
      face=3D"Times New Roman" size=3D2>BR6/OR6: =
CS6</FONT></TR></TBODY></TABLE></DIV>
<DIV><BR><BR><FONT face=3DArial size=3D2>This configuration will not =
work for=20
linux.&nbsp; Linux needs to run in SDRAM starting at zero =
(notice</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>'Load Address' and 'Entry Point' just =
before=20
'uncompressing image'.)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mark =
Chambers</FONT></DIV></BODY></HTML>

------=_NextPart_000_003D_01C5F645.85484710--
