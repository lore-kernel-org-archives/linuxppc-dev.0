Return-Path: <msm@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 0B936685E6
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 11:41:30 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	j9V1odQQ028461
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 18:50:39 -0700 (MST)
Received: from az33exm43.am.freescale.net (az33exm43.am.freescale.net
	[10.64.34.249])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id j9V0hDCI007614
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 18:43:14 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051030151847.C4383353416@atlas.denx.de>
References: <20051030151847.C4383353416@atlas.denx.de>
Content-Type: text/plain; charset=utf-8
Date: Sun, 30 Oct 2005 18:41:00 -0600
Message-Id: <1130719261.7470.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: use of phy_connect() in drivers/net/gianfar.c ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-30 at 08:18 -0700, Wolfgang Denk wrote:

> > As far as I understand there are patches in the -mm tree with
> contain=20
> > the updates for the Gianfar driver. The issue is due to a
>=20
> Do you happen to know of a specific (set of) patch(es)? URL?

I believe this is the patch, however Andy can let you know  for sure on
Monday if I am wrong.

http://ozlabs.org/pipermail/linuxppc-dev/2005-October/020178.html

>=20
> > synchronization issue with the new PHY abstraction layer that was
> added.
>=20
> Yes, obviously. But I am still so na=C3=AFve to expect that  such  change=
s=20
> would not make it untested (the code is not even compile clean) to an=20
> official kernel release like 2.6.14 ?

I assure you we made our best effort to get it all in, but it did not
work out like we wanted.

-Matthew
