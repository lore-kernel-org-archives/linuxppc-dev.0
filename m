Return-Path: <Prabhat_Singh@Satyam.com>
Received: from chnmail.satyam.com (chnmail.satyam.com [210.18.90.100])
	by ozlabs.org (Postfix) with ESMTP id AF843679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 16:32:52 +1100 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by che2.satyam.com (8.12.8/8.12.8) with ESMTP id k2U5HcR4015996
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Mar 2006 10:47:38 +0530
Received: from Disclaimerbng.corp.satyam.ad (bng.satyam.com [172.19.57.211])
	by blr.satyam.com (8.12.8/8.12.8) with ESMTP id k2U5I0f8032227
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Mar 2006 10:48:03 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C653B9.A86CEA24"
Subject: LINUX source code of  WRED Queuing Algorithm 
Date: Thu, 30 Mar 2006 10:50:28 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1018D233F@bsdmsg002.corp.satyam.ad>
From: "Prabhat_Singh" <Prabhat_Singh@Satyam.com>
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

------_=_NextPart_001_01C653B9.A86CEA24
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
         I am implementing voice enabled vpn router using mpc8248 =
processor so i want to implement WRED algorithm for congestion mangement =
in Qos implementation of linux-2.4.24 source code.=20
=20
        Can anyone please tell me , is the implementation of WRED =
algorithm  is available as open source ? If it is not available what =
will be the best solution for  congestion management at peak =
bandwidth(100% traffic) so that voice packet get priortized and not =
dropped at layer-3,only data packet is =20
       dropped.
=20
=20
=20
Thanks
Prabhat Singh
SE
Satyam Computer Services Ltd.  =20


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.

------_=_NextPart_001_01C653B9.A86CEA24
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>Hi all,</FONT></DIV>=0A=
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I =0A=
am implementing voice enabled vpn router using mpc8248 processor so i =
want to =0A=
implement <STRONG>WRED algorithm&nbsp;for congestion mangement =
in&nbsp;Qos =0A=
implementation </STRONG>of linux-2.4.24 source code. </FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>=0A=
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Can =0A=
anyone please tell me , is the implementation of WRED algorithm &nbsp;is =0A=
available&nbsp;as open source&nbsp;? If it is not available what will be =
the =0A=
best solution&nbsp;for&nbsp;</FONT><FONT face=3DArial size=3D2> =
congestion =0A=
management at&nbsp;peak bandwidth(100% traffic) so that voice packet get =0A=
priortized and not dropped at layer-3,only data packet is&nbsp; =
</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
dropped.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Prabhat Singh</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>SE</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Satyam Computer Services =0A=
Ltd.&nbsp;&nbsp;&nbsp;</FONT></DIV><p></p><p>DISCLAIMER:<br>This email =
(including any attachments) is intended for the sole use of the intended =
recipient/s and may contain material that is CONFIDENTIAL AND PRIVATE =
COMPANY INFORMATION. Any review or reliance by others or copying or =
distribution or forwarding of any or all of the contents in this message =
is STRICTLY PROHIBITED. If you are not the intended recipient, please =
contact the sender by email and delete all copies; your cooperation in =
this regard is appreciated..</BODY></HTML>
------_=_NextPart_001_01C653B9.A86CEA24--
