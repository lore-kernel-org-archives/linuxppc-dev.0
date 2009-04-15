Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9939DDFBA
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 16:17:59 +1000 (EST)
Message-Id: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: pci32 code - early_*config*
Date: Wed, 15 Apr 2009 01:17:53 -0500
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I was looking at what I need to get some additional bits of PCI code  
building w/your ppc64 booke patches.  One thing it looks like we need  
is the early config cycle code.  The question I have is do we think we  
still need the null_ops support?  Also do we think we every get called  
with a NULL hose?

This is fake_pci_bus() in arch/powerpc/kernel/pci_32.c

- k
