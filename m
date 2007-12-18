Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0CB08DDE32
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 07:29:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ppc405 in EDK9.2
Date: Tue, 18 Dec 2007 12:29:33 -0800
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	<simekm2@fel.cvut.cz>
Message-Id: <20071218202934.AED3DC1005A@mail134-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


	=09
The PPC405 in EDK9.2 and beyond has a slightly different set of bus
interfaces than before.  I've updated the BSP generator to handle it,
and added some test cases.  The updates are at
git://git.xilinx.com/gen-mhs-devtree.git

Steve
