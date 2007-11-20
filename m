Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail17-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 655A5DDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 07:15:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Xilinx EDK BSP generation of device trees for microblaze and PowerPC
Date: Tue, 20 Nov 2007 11:44:58 -0800
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <microblaze-uclinux@itee.uq.edu.au>, <linuxppc-dev@ozlabs.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"Michal Simek" <simekm2@fel.cvut.cz>
Message-Id: <20071120194411.E183B100060@mail17-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=09
I've updated some code from Michel Simek to generate Flat Device Trees
from Xilinx EDK projects.  This code is now hosted at:
git://git.xilinx.com/gen-mhs-devtree.git

This has one major advantage over the gen-mhs-devtree.py approach:
default IP core parameters that are not specified in the mhs file can
now be generated, since EDK pulls these in from the core .mpd file.
I've also managed to incorporate a few more improvements from the
previous review, so the BSP generator should include at least as much
information as gen-mhs-devtree.py

The next major order of business is to represent the DMA engines in the
MPMC and locallink connections to the lltemac.

Steve
