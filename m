Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1A874DDF59
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 10:29:11 +1000 (EST)
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m850IjOm003788
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Sep 2008 17:18:45 -0700
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m850IjiB006173
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 Sep 2008 00:18:45 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C90EEC.F5CA89A3"
Subject: One image for two different core
Date: Thu, 4 Sep 2008 17:18:45 -0700
Message-ID: <F795765B112E7344AF36AA9112796415069F1682@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C90EEC.F5CA89A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am doing a feasibility study whether I can have one image for two
different  platform with e300 ad e500 core. The idea is uboot will
detect which type of the processor is running and pass the information
to the early Linux startup, then the code will configure itself based on
what type of core it is.

One of the issue I see is the tool chain,.

I would like to get your opinion on this please.

Many thanks in advance,

Bizhan


------_=_NextPart_001_01C90EEC.F5CA89A3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3354" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<P><FONT face=3DArial size=3D2>Hi All,</FONT></P>
<P><FONT face=3DArial size=3D2>I am doing a feasibility study whether I =
can have one=20
image for two&nbsp;<SPAN =
class=3D265451800-05092008>different</SPAN>&nbsp;=20
platform with e300 ad e500 core. The idea is uboot will detect which =
type of the=20
processor is running and pass the information to the early Linux =
startup, then=20
the code will configure itself based on what&nbsp;<SPAN=20
class=3D265451800-05092008>type of </SPAN>core it is.</FONT></P>
<P><FONT face=3DArial size=3D2></FONT></P>
<P><FONT face=3DArial size=3D2>One of the issue I see is the tool =
chain,.</FONT></P>
<P><FONT face=3DArial size=3D2>I would like to get your opinion on this=20
please.</FONT></P>
<P><FONT face=3DArial size=3D2></FONT></P>
<P><FONT face=3DArial size=3D2></FONT></P>
<P><FONT face=3DArial size=3D2>Many thanks in advance,</FONT></P>
<P><FONT face=3DArial size=3D2>Bizhan</FONT></P></DIV></BODY></HTML>

------_=_NextPart_001_01C90EEC.F5CA89A3--
