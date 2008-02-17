Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02EBDDE127
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 22:39:31 +1100 (EST)
Date: Sun, 17 Feb 2008 06:39:43 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Sequoia NAND
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080217113932.02EBDDE127@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't see where the new powerpc architecture and drivers/mtd/nand 
contains support for the NAND chip on the Sequoia platform.  We have 
a Linux 2.6.14 kit where Montavista has a driver in "sequoia_nand.c" 
which interfaces with the NAND device via NAND Flash Control registers:
    struct ppc440ep_ndfc_regs *sequoia_ndfc;
where:
    struct ppc440ep_ndfc_regs {
         uint cmd;
         uint addr;
         uint data;
         uint reserved1;
         uint ecc0;
         uint ecc1;
         uint ecc2;
         uint ecc3;
         uint ecc4;
         uint ecc5;
         uint ecc6;
         uint ecc7;
         uint b0cr;
         uint b1cr;
         uint b2cr;
         uint b3cr;
         uint cr;
         uint sr;
         uint hwctl;
         uint reserved2;
         uint revid;
};

Is the Sequoia's NAND Flash Controller supported in the current Linux-2.6.25?

thanks,
Steve
