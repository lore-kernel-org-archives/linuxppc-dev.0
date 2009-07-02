Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EA60DB713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 18:13:33 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 19ADEDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 18:13:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Direct MII connection between MPC8313 and VIRTEX FPGA
Date: Thu, 2 Jul 2009 10:13:27 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7F171@ex01.ads.ubidyne.de>
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

Thank you very much so far. It helped me a lot!

Best regards
Frank

=20
=20
=20
=09
> -----Urspr=FCngliche Nachricht-----
> Von: =
linuxppc-dev-bounces+frank.prepelica=3Dubidyne.com@lists.ozlabs.org
> =
[mailto:linuxppc-dev-bounces+frank.prepelica=3Dubidyne.com@lists.ozlabs.o=
rg]
> Im Auftrag von Grant Likely
> Gesendet: Dienstag, 30. Juni 2009 18:17
> An: Frank Prepelica
> Cc: linuxppc-dev@ozlabs.org
> Betreff: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
>=20
> On Tue, Jun 30, 2009 at 2:35 AM, Frank
> Prepelica<Frank.Prepelica@ubidyne.com> wrote:
> >> What kernel version are you using?
> >
> > We are using kernel version 2.6.24. I've searched for "current =
speed" in
> version 2.6.28.7 and I've found that string.
> >
> >> Yes, you need to modify the DTB. =A0You have a back to back MII
> >> connection, not a phy, so you do *not* want to have a PHY node in =
the
> >> device tree.
> >
> > Hmm, but I do have a "PHY", don't I?. The "PHY" will be emulated in =
the
> FPGA. Of course, it's not a physical PHY but it should look like one.
>=20
> No, it sounds like you don't.  If you've got a back-to-back MII
> connection, then you can fix the link speed and you don't need to do
> any form of PHY emulation.  ie. you don't need to wire up the MDIO
> pins.
>=20
> > So, do I really need the remove the complete PHY description in the =
DTB?
>=20
> yes.
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
