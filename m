Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0304ADDED4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 20:17:39 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2D9HXZo002788 for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 02:17:33 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2D9HWMn019859
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 04:17:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Subject: RE: fsldma seems to be buggy, noticed in loop mode
Date: Thu, 13 Mar 2008 17:17:31 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AED32E67@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080313091308.GA17132@Chamillionaire.breakpoint.cc>
References: <20080312180421.GC7255@Chamillionaire.breakpoint.cc>
	<ABF87B0B6A38C0458E319AC973ED68AED32DD2@zch01exm26.fsl.freescale.net>
	<20080313091308.GA17132@Chamillionaire.breakpoint.cc>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Sebastian Siewior" <linuxppc-embedded@ml.breakpoint.cc>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Sebastian Siewior [mailto:linuxppc-embedded@ml.breakpoint.cc]=20
>=20
> * Zhang Wei | 2008-03-13 15:03:54 [+0800]:
>=20
> >Could you please apply these two patches and test again?
> >
> >http://lkml.org/lkml/2008/3/10/64
> >http://lkml.org/lkml/2008/3/13/36
> Ui, that fast. Did you find this on your own or after me=20
> reporting that
> bug?
> It solves my FIFO problem, thanks.
>=20
Just after you reported. :)

Cheers!
Wei.
