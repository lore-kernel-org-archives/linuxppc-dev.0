Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zf22F36xYzF0dR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 06:25:09 +1100 (AEDT)
Date: Sat, 10 Feb 2018 12:09:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] PCI fixes for v4.16
Message-ID: <20180210180920.GF206223@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI fixes:

  - fix POWER9/powernv INTx regression from the merge window (Alexey
    Kardashevskiy)


The following changes since commit ab8c609356fbe8dbcd44df11e884ce8cddf3739e:

  Merge branch 'pci/spdx' into next (2018-02-01 11:40:07 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.16-fixes-1

for you to fetch changes up to c591c2e36ccc9a08f265841d2fd68e35327ab3c4:

  powerpc/pci: Fix broken INTx configuration via OF (2018-02-10 11:49:56 -0600)

----------------------------------------------------------------
pci-v4.16-fixes-1

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/pci: Fix broken INTx configuration via OF

 arch/powerpc/kernel/pci-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
