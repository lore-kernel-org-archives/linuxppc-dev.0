Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 241C0DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:29:48 +1000 (EST)
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 0/3][POWERPC] Add PCI support for 44xEPx
Date: Sat, 25 Aug 2007 13:29:39 +0400
Message-ID: <20070825091440.4087.1428.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series is a port of 440EPx (sequoia) PCI host bridge from
arch/ppc. It was initiated with some inconsistencies observed in pci_32.c
pci ranges parsing, so I've eventually merged pci_32 and pci_64 of
pci_process_bridge_OF_ranges() into one, that should be able to handle
64-bit phys addresses, including fancy 44x 36-bit addressing.

Actual PCI stuff was implemented more as a use-case for the upper, and is
more or less straight port from arch/ppc. It assumes 

[PATCH 0/4] PowerPC 440EPx: Initial Sequoia support take 2

from Valentine applied, and hereby is for for-2.6.24 branch of jwb's tree
(git pull git://git.infradead.org/users/jwboyer/powerpc.git for-2.6.24)

-- 
Sincerely, Vitaly
