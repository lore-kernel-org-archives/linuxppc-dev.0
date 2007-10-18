Return-Path: <pjmaiya@signal-networks.com>
Received: from smtp.net4india.com (smtp.net4india.com [202.71.129.66])
	by ozlabs.org (Postfix) with ESMTP id A2CEBDDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 10:35:06 +1000 (EST)
Received: from [61.95.204.104] (helo=signal-networks.com)
	by smtp.net4india.com with esmtp (Exim 4.54) id 1IiSSK-00058n-2K
	for linuxppc-embedded@ozlabs.org; Thu, 18 Oct 2007 15:48:20 +0530
Received: from pjmaiya ([192.168.1.70])
	by signal-networks.com (mail.signal-networks.com [192.168.1.1])
	(MDaemon Standard v9.5.6) with ESMTP id md50000151601.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 18 Oct 2007 15:54:33 +0530
Message-ID: <005e01c81171$11421820$4601a8c0@signet>
From: "pjmaiya" <pjmaiya@signal-networks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: tiny login: useradd command
Date: Thu, 18 Oct 2007 15:54:29 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_005B_01C8119F.2AE9B250"
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

------=_NextPart_000_005B_01C8119F.2AE9B250
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
 I am using montavista linux. Using TCT tool i have added package for =
user creation. I am having following problem
  a.. If I use tiny login package, I will be getting useradd binary but =
number of parameter are few like
 Usage: adduser [OPTIONS]... <USER>
Options:

  -h <directory>    specify home directory
  -s <shell>        specify shell
  -g <gecos>        specify GECOS stringa.. If I don't use tiny login =
package, I will be selecting useradd package from admin menu. But I am =
unable to execute this command since it gives follwing error
      /usr/sbin/groupadd missing..
=20
  a.. Actually I want useradd command similar to linux where more =
argument are taken, especially I wanted 'user' to be part of more than =
one group.
can anyone help me out..

thanx in advance,
pjmaiya
------=_NextPart_000_005B_01C8119F.2AE9B250
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1601" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;I am using montavista linux. =
Using TCT tool i=20
have added package for user creation. I am having following =
problem</FONT></DIV>
<UL>
  <LI><FONT face=3DArial size=3D2>If I use tiny login package, I will be =
getting=20
  useradd binary but number of parameter are few like</FONT></LI></UL>
<DIV><FONT face=3DArial size=3D2><!--StartFragment --><FONT =
face=3D"Times New Roman"=20
size=3D3>&nbsp;</FONT>Usage: adduser [OPTIONS]... &lt;USER&gt;
<P>Options:</P><PRE>  -h &lt;directory&gt;    specify home directory
  -s &lt;shell&gt;        specify shell
  -g &lt;gecos&gt;        specify GECOS string</PRE></FONT></DIV>
<UL>
  <LI><FONT face=3DArial size=3D2>If I don't use tiny login package, I =
will be=20
  selecting&nbsp;useradd package from admin menu. But I am unable to =
execute=20
  this command since it gives follwing error</FONT></LI></UL>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/usr/sbin/groupadd=20
missing..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<UL>
  <LI><FONT face=3DArial size=3D2>Actually I want useradd command =
similar to linux=20
  where more argument are taken, especially I wanted 'user' to be part =
of more=20
  than one group.</FONT></LI></UL>
<DIV><FONT face=3DArial size=3D2>can anyone help me out..</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>thanx in advance,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>pjmaiya</FONT></DIV></BODY></HTML>

------=_NextPart_000_005B_01C8119F.2AE9B250--
