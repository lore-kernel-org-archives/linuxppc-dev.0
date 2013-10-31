Return-Path: <thomas@net.t-labs.tu-berlin.de>
Received: from mail.net.t-labs.tu-berlin.de (mail.net.t-labs.tu-berlin.de
 [IPv6:2001:470:96b9:4:130:149:220:252])
 by ozlabs.org (Postfix) with ESMTP id 209C32C0376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 22:51:11 +1100 (EST)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_F17B7A92-4BE5-428B-A876-03148DDAC996"
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: Gianfar driver crashes in Kernel v3.10
From: =?iso-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
In-Reply-To: <525E3BD7.1020208@freescale.com>
Date: Thu, 31 Oct 2013 12:51:03 +0100
Message-Id: <05E1EDFE-EDFB-4E6F-AA83-D353B4032CA5@net.t-labs.tu-berlin.de>
References: <90BE8C5D-E23B-41B5-BB52-8A0C0758931D@net.t-labs.tu-berlin.de>
 <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
 <525E3BD7.1020208@freescale.com>
To: "claudiu.manoil@freescale.com" <claudiu.manoil@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_F17B7A92-4BE5-428B-A876-03148DDAC996
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hi Claudiu,


> Please try the following patch:
> http://patchwork.ozlabs.org/patch/283235/
>=20
> It should help with your issue.
>=20

Several OpenWrt users including myself have tested your patch on =
TPLink-4900 routers.
We do have positive feedback, as no crash nor system freeze was reported =
for different=20
network loads and router setups.=20
All different scenarios / details and two digit uptimes are in this =
forum thread:
https://forum.openwrt.org/viewtopic.php?id=3D42062&p=3D13

Thanks again for your work and  I hope to see this patch merged =
upstream.

Greetings Thomas


--Apple-Mail=_F17B7A92-4BE5-428B-A876-03148DDAC996
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=iso-8859-1

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Diso-8859-1"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div><div style=3D"font-size: 14px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><font =
color=3D"#000000">Hi =
Claudiu,</font><br></div><div><br></div><br><blockquote type=3D"cite"><div=
 style=3D"font-size: 14px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">Please try the following patch:<br><a =
href=3D"http://patchwork.ozlabs.org/patch/283235/">http://patchwork.ozlabs=
.org/patch/283235/</a><br><br>It should help with your =
issue.<br><br></div></blockquote><div><br></div><div>Several OpenWrt =
users including myself have tested your patch on TPLink-4900 =
routers.</div><div>We do have positive feedback, as no crash nor system =
freeze was reported for different&nbsp;</div><div>network loads and =
router setups.&nbsp;</div><div>All different scenarios / details and two =
digit uptimes are in this forum thread:</div><div><a =
href=3D"https://forum.openwrt.org/viewtopic.php?id=3D42062&amp;p=3D13">htt=
ps://forum.openwrt.org/viewtopic.php?id=3D42062&amp;p=3D13</a></div><div><=
br></div><div>Thanks again for your work and &nbsp;I hope to see this =
patch merged upstream.</div><div><br></div><div>Greetings =
Thomas</div><div><br></div></div></body></html>=

--Apple-Mail=_F17B7A92-4BE5-428B-A876-03148DDAC996--
