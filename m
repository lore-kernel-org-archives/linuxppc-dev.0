Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01A7BDDF76
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:48:14 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l51Hm82A003412
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:48:09 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51Hm8aX021225
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:48:08 -0500 (CDT)
Subject: [PATCH 0/8] Add Generic PCI-E support to 8641HPCN
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720088.14219.60.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:48:08 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This 8-part patch set combines the two previous patch
sets, 5 from Zheng Wei, and 3 from me, along with one
from Wade Farnsworth into one nice-n-happy set, all
designed to re-enable PCI-Express on the MPC8641HPCN board.

Yes, there is one hacky bus number adjusting being done
in  _exclude_device(), but I think I read that it will
take some fairly serious effort to rewrite the PPC-32
version of PCI bus numbering to make it "right".

In the meantime, these patches work, and will enable us
to add on the 8548 and 8544 PCI-Express code as well.

These are rebased to your current top-of-master branch.

Thanks,
jdl
