Return-Path: <pjmaiya@signal-networks.com>
Received: from smtp.net4india.com (smtp.net4india.com [202.71.129.68])
	by ozlabs.org (Postfix) with ESMTP id 81B7EDDECA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 21:17:16 +1000 (EST)
Received: from [61.95.204.104] (helo=signal-networks.com)
	by smtp.net4india.com with esmtp (Exim 4.54) id 1Hm6dy-0002Dp-SO
	for linuxppc-embedded@ozlabs.org; Thu, 10 May 2007 16:47:11 +0530
Received: from pjmaiya ([192.168.1.70])
	by signal-networks.com (mail.signal-networks.com [192.168.1.1])
	(MDaemon Standard v9.0.1) with ESMTP id md50000097485.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 May 2007 16:46:27 +0530
Message-ID: <010001c792f4$a5d3dfb0$4601a8c0@signet>
From: "pjmaiya" <pjmaiya@signal-networks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RTC drift in PPC
Date: Thu, 10 May 2007 16:46:25 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00FD_01C79322.BF7B79E0"
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

------=_NextPart_000_00FD_01C79322.BF7B79E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi,
  We are running RTC on mpc860 board with external crystal. During boot =
we get date and time from h/w RTC chip and then it runs pn software =
tick, which is handled by kernel. We are getting 4 minutes drift for 21 =
hours. Can any one suggest, how to reduce the drift.

thnax in advance,
pjmaiya
------=_NextPart_000_00FD_01C79322.BF7B79E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1589" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; We are running RTC on mpc860 =
board with=20
external crystal. During boot&nbsp;we get date and time from h/w RTC =
chip and=20
then it runs&nbsp;pn software tick, which is handled by kernel. We are =
getting 4=20
minutes drift for 21 hours. Can any one suggest, how to reduce the=20
drift.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>thnax in advance,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>pjmaiya</FONT></DIV></BODY></HTML>

------=_NextPart_000_00FD_01C79322.BF7B79E0--
