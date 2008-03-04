Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0026.austin.hp.com (g1t0026.austin.hp.com [15.216.28.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 79158DDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 05:56:14 +1100 (EST)
Message-Id: <20080304185646.864917286@ldl.fc.hp.com>
Date: Tue, 04 Mar 2008 11:56:46 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 00/16] PCI: consolidate several pcibios_enable_resources()
	implementations, v3
Cc: Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series replaces most of the arch-specific pcibios_enable_resources()
implementations with a single generic pci_enable_resources().

I think this is ready for -mm, but of course, I'm still interested in
any other comments.

Changes between v2 and v3:
    
    - Renamed the generic version to pci_enable_resources(), to keep
      pcibios_* names for arch-specific code (suggested by Kyle, thanks).

    - I reorganized this series into a single PCI patch that adds the new
      generic version, followed by a bunch of patches that individually
      convert each arch over to use it.

Bjorn

-- 
