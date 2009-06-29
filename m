Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36A6EB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 18:23:13 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 2E5B4DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 18:23:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Direct MII connection between MPC8313 and VIRTEX FPGA
Date: Mon, 29 Jun 2009 10:23:06 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7EE1A@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant

Thanks for your response!

I have searched for "current-speed" in drivers/net/fec_mpc52xx.c but I =
cannot find anything. However we are using the gianfar.c Ethernet =
driver.
Do you know whether this driver supports fixed MII links without PHY?

I've got another question regarding MII connection between and MPC and a =
Virtex FPGA. Whats about the PHY address which has to be set in the DTB =
file? Do I have to modify the DTB at all?


Thank you!


Best regards
Frank

=20
=20
=20
=09
		=20
=20

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:             +49 731 88 00 71 58
Fax:                 +49 731 88 00 71 99
Email:              frank.prepelica@ubidyne.com
Homepage:       www.ubidyne.com
=20
Registered office: Ulm
District court of Ulm: HRB 5295
Managing Directors:
Dipl. Ing. Ken Hawk
Dipl. Ing. Beat M=FCller
Dipl. Ing. Mike Levis

> -----Urspr=FCngliche Nachricht-----
> Von: Grant Likely [mailto:grant.likely@secretlab.ca]
> Gesendet: Donnerstag, 25. Juni 2009 22:06
> An: Frank Prepelica
> Cc: linuxppc-dev@ozlabs.org
> Betreff: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
>=20
> On Thu, Jun 25, 2009 at 9:11 AM, Frank
> Prepelica<Frank.Prepelica@ubidyne.com> wrote:
> > Hi all,
> >
> > we removed the ethernet PHYs (MARVELL) from our customized board =
(based
> on MPC8313ERDB) and
> > connected the CPU Ethernet lines directly to a FPGA which is now
> emulating the PHY. But the ifconfig
> > command cannot find that eth device anymore. Does the emulated PHY =
needs
> to provide MDIO
> > information that the ETH device can be found again?
>=20
> No, you just need to make sure that the Ethernet driver is able to
> support fixed speed MII links without a PHY.  It's trivial to do, but
> not all drivers support it.  Search for "current-speed" in
> drivers/net/fec_mpc52xx.c for an example.
>=20
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
