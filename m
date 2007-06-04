Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2D5DDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:29:54 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54MTnY7009073
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:29:49 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MTmMi021822
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:29:49 -0500 (CDT)
Subject: [PATCH v2 0/9] Add Generic PCI-E support to 8641HPCN
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996188.9632.68.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:29:48 -0500
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

This is version 2 of the patch set and incorporates
improvements suggested by list reviewers.

Yes, there is one hacky bus number adjusting being done
in  _exclude_device(), but I think I read that it will
take some fairly serious effort to rewrite the PPC-32
version of PCI bus numbering to make it "right".

In the meantime, these patches work, and will enable us
to add on the 8548 and 8544 PCI-Express code as well.

These are rebased to your current top-of-master branch.

Thanks,
jdl
