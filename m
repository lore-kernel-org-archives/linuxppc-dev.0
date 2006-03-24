Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D437567B56
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 11:37:04 +1100 (EST)
Subject: pci_dlpar.c & probe mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 24 Mar 2006 11:36:16 +1100
Message-Id: <1143160576.4257.51.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I noticed that pcibios_add_pci_devices() test the platform type to
decide wether to do a device-tree based probe or a direct PCI probe. Why
can't it use ppc_md.probe_mode() like the rest of the PCI code does ?

Ben.
