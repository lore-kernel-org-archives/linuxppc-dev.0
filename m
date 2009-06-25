Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0A787B707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 01:24:08 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 20B9EDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 01:24:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Direct MII connection between MPC8313 and VIRTEX FPGA
Date: Thu, 25 Jun 2009 17:11:53 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7ED46@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

we removed the ethernet PHYs (MARVELL) from our customized board (based =
on MPC8313ERDB) and=20
connected the CPU Ethernet lines directly to a FPGA which is now =
emulating the PHY. But the ifconfig=20
command cannot find that eth device anymore. Does the emulated PHY needs =
to provide MDIO=20
information that the ETH device can be found again?

Any help is very appreciated

Best regards
Frank





Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 58
Fax:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 99
Email:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
frank.prepelica@ubidyne.com
Homepage:=A0=A0=A0=A0=A0=A0 www.ubidyne.com
=A0
Registered office: Ulm
District court of Ulm: HRB 5295
Managing Directors:
Dipl. Ing. Ken Hawk
Dipl. Ing. Beat M=FCller
Dipl. Ing. Mike Levis
