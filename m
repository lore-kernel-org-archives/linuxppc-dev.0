Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D728B70BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 18:35:52 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 7C5A1DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 18:35:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Direct MII connection between MPC8313 and VIRTEX FPGA
Date: Tue, 30 Jun 2009 10:35:46 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7EF7B@ex01.ads.ubidyne.de>
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

> What kernel version are you using?

We are using kernel version 2.6.24. I've searched for "current speed" in =
version 2.6.28.7 and I've found that string.

> Yes, you need to modify the DTB.  You have a back to back MII
> connection, not a phy, so you do *not* want to have a PHY node in the
> device tree.

Hmm, but I do have a "PHY", don't I?. The "PHY" will be emulated in the =
FPGA. Of course, it's not a physical PHY but it should look like one.
So, do I really need the remove the complete PHY description in the DTB?


=09
		=20
=20

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany



> -----Urspr=FCngliche Nachricht-----
> Von: Grant Likely [mailto:grant.likely@secretlab.ca]
> Gesendet: Montag, 29. Juni 2009 17:40
> An: Frank Prepelica
> Cc: linuxppc-dev@ozlabs.org
> Betreff: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
>=20
> On Mon, Jun 29, 2009 at 2:23 AM, Frank
> Prepelica<Frank.Prepelica@ubidyne.com> wrote:
> > Hi Grant
> >
> > Thanks for your response!
> >
> > I have searched for "current-speed" in drivers/net/fec_mpc52xx.c but =
I
> cannot find anything. However we are using the gianfar.c Ethernet =
driver.
> > Do you know whether this driver supports fixed MII links without =
PHY?
>=20
> What kernel version are you using?
>=20
> > I've got another question regarding MII connection between and MPC =
and a
> Virtex FPGA. Whats about the PHY address which has to be set in the =
DTB
> file? Do I have to modify the DTB at all?
>=20
> Yes, you need to modify the DTB.  You have a back to back MII
> connection, not a phy, so you do *not* want to have a PHY node in the
> device tree.
>=20
> g.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
