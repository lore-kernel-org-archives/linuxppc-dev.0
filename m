Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out02.wipro.com
	[203.91.198.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6417B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 15:45:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC5330.EF8B1672"
Subject: FW: Ethernet driver WR linux
Date: Fri, 5 Aug 2011 11:01:32 +0530
Message-ID: <07ACDFB8ECA8EF47863A613BC01BBB220344E2AB@HYD-MKD-MBX02.wipro.com>
From: <smitha.vanga@wipro.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC5330.EF8B1672
Content-Type: text/plain;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi
 
I have bringup WR linux 2.6.38 on a custom mpc8247 board. Not able to
configure the ipaddress.  When I boot my linux kernel I get the below
message.
Also I am using the fec 1.  The fec is not getting initialized. 
fs_enet.c:v1.0 (Aug 8, 2005)
BB MII Bus: Cannot register as MDIO bus
fsl-bb-mdio: probe of fsl-bb-mdio.0 failed with error -1
BB MII Bus: Cannot register as MDIO bus
fsl-bb-mdio: probe of fsl-bb-mdio.1 failed with error -1

I have enabled the following:
 
CONFIG_NET_ETHERNET=3Dy

CONFIG_MII=3Dy

CONFIG_FS_ENET=3Dy

# CONFIG_FS_ENET_HAS_SCC is not set

CONFIG_FS_ENET_HAS_FCC=3Dy

 
Regards,
Smitha

Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

------_=_NextPart_001_01CC5330.EF8B1672
Content-Type: text/html;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3698" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN 
class=3D443520516-04082011>Hi</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D443520516-04082011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D443520516-04082011>I have 
bringup&nbsp;WR linux 2.6.38 on a custom mpc8247 board.&nbsp;Not able to 
configure the ipaddress. &nbsp;When I boot my linux kernel I get the below 
message.</SPAN></FONT></DIV>
<DIV><SPAN class=3D443520516-04082011><FONT face=3DArial><FONT size=3D2>Also=
 I am 
using the fec 1.<SPAN class=3D599103705-05082011>&nbsp; The fec is not 
getting&nbsp;initialized.&nbsp;</SPAN></FONT></FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D443520516-04082011>fs_enet.c:=
v1.0 (Aug 
8, 2005)<BR>BB MII Bus: Cannot register as MDIO bus<BR>fsl-bb-mdio: probe of=
 
fsl-bb-mdio.0 failed with error -1<BR>BB MII Bus: Cannot register as MDIO 
bus<BR>fsl-bb-mdio: probe of fsl-bb-mdio.1 failed with error 
-1<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D443520516-04082011>I have ena=
bled the 
following:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D443520516-04082011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D443520516-04082011><SPAN lang=
=3DEN>
<P>CONFIG_NET_ETHERNET=3Dy</P>
<P>CONFIG_MII=3Dy</P>
<P>CONFIG_FS_ENET=3Dy</P>
<P># CONFIG_FS_ENET_HAS_SCC is not set</P>
<P>CONFIG_FS_ENET_HAS_FCC=3Dy</P></SPAN></DIV></SPAN></FONT>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D443520516-04082011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D443520516-04082011>Regards,<BR>Smitha</DIV></SPAN></FONT><P><strong>=
<span style=3D'font-size:10.0pt;font-family:=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</BODY></HTML>

------_=_NextPart_001_01CC5330.EF8B1672--
