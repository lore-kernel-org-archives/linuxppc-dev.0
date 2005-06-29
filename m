Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (69.37.28.78.adsl.snet.net [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 07A4867B68
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 23:52:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57CB0.206AD40C"
Date: Wed, 29 Jun 2005 09:40:34 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B044402F5@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GX EMAC driver hang?
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

------_=_NextPart_001_01C57CB0.206AD40C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am doing a Linux 2.6.11.11 port for a CPCI board with a 440GX
processor on it.  Previously, I had successfully ported 2.6.11.11 to the
board's predecessor running on a 440GP processor.  Due to limitations in
this version of the PCB, EMAC ports 2 and 3 are not connected.  The
standalone kernel comes up and gets into a BusyBox shell.  When I try to
ifconfig the eth0 interface, the messages "eth0: Link is Up" and "eth0:
Speed: 100, Full duplex." are displayed and then the target hangs.  I
used the OCOTEA port as a pattern for my 440GP->440GX conversion.  The
PHYs which are connected to EMAC ports 0 and 1 are the same PHYs as on
the 440GP board (running in RMII mode).  I have tried to use the
function "ocp_remove_one_device" to whack EMAC2 and EMAC3.  I am pretty
sure that the removal worked as I no longer see init messages for those
EMACs (previously I saw all four devices get initialized).  The MAL
reports that it has "Initialized, 4 tx channels, 4 rx channels."  I used
the function "ibm440gx_set_eth_grp" to force the Ethernets to both group
0 and group 1 configurations.  So far, nothing has worked.  Can anyone
think of anything obvious that I am missing?  I know that the Ethernet
ports are functional as I used TFTP with our ROM monitor package to
download the zImage file.


Thanks,

Scott


___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________


------_=_NextPart_001_01C57CB0.206AD40C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.36">
<TITLE>440GX EMAC driver hang?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Hi,</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">I am doing a Linux 2.6.11.11 port for a CPCI board with a 440GX =
processor on it.&nbsp; Previously, I had successfully ported 2.6.11.11 =
to the board&#8217;s predecessor running on a 440GP processor.&nbsp; Due =
to limitations in this version of the PCB, EMAC ports 2 and 3 are not =
connected.&nbsp; The standalone kernel comes up and gets into a BusyBox =
shell.&nbsp; When I try to ifconfig the eth0 interface, the messages =
&#8220;eth0: Link is Up&#8221; and &#8220;eth0: Speed: 100, Full =
duplex.&#8221; are displayed and then the target hangs.&nbsp; I used the =
OCOTEA port as a pattern for my 440GP-&gt;440GX conversion.&nbsp; The =
PHYs which are connected to EMAC ports 0 and 1 are the same PHYs as on =
the 440GP board (running in RMII mode).&nbsp; I have tried to use the =
function &#8220;ocp_remove_one_device&#8221; to whack EMAC2 and =
EMAC3.&nbsp; I am pretty sure that the removal worked as I no longer see =
init messages for those EMACs (previously I saw all four devices get =
initialized).&nbsp;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">The MAL reports that =
it has</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Courier New">&#8220;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New">Initialized, 4 tx channels, 4 rx =
channels.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&#8221;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Courier New">I used the function =
&#8220;ibm440gx_set_eth_grp&#8221; to force the Ethernets to both group =
0 and group 1 configurations.&nbsp; So far, nothing has worked.&nbsp; =
Can</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Courier New">anyone</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Courier New"> think of anything obvious that I am missing?&nbsp; =
I know that the Ethernet ports are functional as I used TFTP with our =
ROM monitor package to download the zImage file.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"></SPAN><A NAME=3D""><SPAN =
LANG=3D"en-us"></SPAN></A></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Thanks,</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">Scott</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>
<BR>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">___________________________________________________________________<=
/FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; Scott N. Coulter</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; Senior Software Engineer</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; Cyclone =
Microsystems&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; 370 James =
Street&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Phone:&nbsp; 203.786.5536 ext. 118</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; New Haven, CT 06513-3051&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Email:&nbsp; scott.coulter@cyclone.com</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp; =
U.S.A.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Web:&nbsp;&nbsp;&nbsp; <A =
HREF=3D"http://www.cyclone.com">http://www.cyclone.com</A></FONT></SPAN><=
/P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">___________________________________________________________________<=
/FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C57CB0.206AD40C--
