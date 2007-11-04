Return-Path: <kugel@163.com>
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
	by ozlabs.org (Postfix) with SMTP id 5886CDDDF4
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 03:33:30 +1100 (EST)
From: "Kugel" <kugel@163.com>
To: <linuxppc-dev@ozlabs.org>
Subject: mpc852t boot question!
Date: Mon, 5 Nov 2007 00:18:11 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0015_01C81F41.5A04D2E0"
Message-Id: <472DF45A.29BBA2.01664@m12-14.163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C81F41.5A04D2E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 I made a MPC852T board. I set the HW config word to 0x04600000(D5,D9,D10
pulled up).So the [ISB]=00, 
 
and the IMMR = 0x00000000. 
 
 When the CPU is power up, can it boot from external boot flash(39vf040)? Or
just run from internal 
 
memory space(because the IMMR=0x0)? 
 

------=_NextPart_000_0015_01C81F41.5A04D2E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16544" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN =
class=3D909420516-04112007>&nbsp;I made a MPC852T=20
board. I set the HW config word to 0x04600000(D5,D9,D10 pulled up).So =
the=20
[ISB]=3D00, </SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN=20
class=3D909420516-04112007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN =
class=3D909420516-04112007>and the IMMR =3D=20
0x00000000. </SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN=20
class=3D909420516-04112007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN =
class=3D909420516-04112007>&nbsp;When the CPU is=20
power up, can it boot from external boot flash(39vf040)? Or =
just&nbsp;run from=20
internal </SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN=20
class=3D909420516-04112007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN =
class=3D909420516-04112007>memory space(because=20
the IMMR=3D0x0)?&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; size=3D2><SPAN=20
class=3D909420516-04112007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0015_01C81F41.5A04D2E0--
