Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B4539B71DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 17:29:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0ED36DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 17:29:49 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5C7TjLs012480
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 02:29:46 -0500
Subject: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 17:29:44 +1000
Message-Id: <1244791784.7172.69.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I pushed the following commits, along with merging Linus tree in today.

Note that it will not boot on various machines unless the allocator
init ordering problem I mentioned earlier is fixed.

Benjamin Herrenschmidt (1):
      powerpc: Fix bug in move of altivec code to vector.S

Josh Boyer (3):
      powerpc/4xx: Disable PCI_LEGACY
      powerpc/40x: Convert AMCC Makalu board to ppc40x_simple
      powerpc/40x: Convert AMCC Kilauea/Halekala boards to ppc40x_simple

Sean MacLennan (1):
      i2c: Fix confusing i2c-ibm_iic message

Stefan Roese (1):
      powerpc/4xx: Sequoia: Enable NAND support
