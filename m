Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD720B709D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 02:26:09 +1000 (EST)
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211]) by ozlabs.org (Postfix) with ESMTP id 04086DDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 02:26:08 +1000 (EST)
Received: by gxk7 with SMTP id 7so1844978gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 09:26:05 -0700 (PDT)
MIME-Version: 1.0
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 6 Jun 2009 10:25:45 -0600
Message-ID: <fa686aa40906060925w18fc4c39ld2a59718a32ee996@mail.gmail.com>
Subject: Please pull -next branch from git.secretlab.ca
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here are some new commits to support the Xilinx ML507 board for 2.6.31

The following changes since commit baf75b0a42a1b3f6fca80f8949b6141eaff61b0d:
  Stephen Rothwell (1):
        powerpc/pci: Fix annotation of pcibios_claim_one_bus

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Grant Likely (1):
      powerpc/virtex: refactor intc driver and add support for i8259 cascading

Roderick Colenbrander (3):
      powerpc/virtex: Add support for Xilinx PCI host bridge
      powerpc/virtex: Add Xilinx ML510 reference design support
      powerpc/virtex: Add ml510 reference design device tree

 arch/powerpc/boot/dts/virtex440-ml510.dts |  465 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/xilinx_pci.h     |   21 ++
 arch/powerpc/platforms/40x/virtex.c       |    2 +
 arch/powerpc/platforms/44x/Kconfig        |   13 +-
 arch/powerpc/platforms/44x/Makefile       |    1 +
 arch/powerpc/platforms/44x/virtex.c       |    2 +
 arch/powerpc/platforms/44x/virtex_ml510.c |   29 ++
 arch/powerpc/platforms/Kconfig            |    4 +
 arch/powerpc/sysdev/Makefile              |    1 +
 arch/powerpc/sysdev/xilinx_intc.c         |   81 ++++--
 arch/powerpc/sysdev/xilinx_pci.c          |  132 ++++++++
 11 files changed, 732 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml510.dts
 create mode 100644 arch/powerpc/include/asm/xilinx_pci.h
 create mode 100644 arch/powerpc/platforms/44x/virtex_ml510.c
 create mode 100644 arch/powerpc/sysdev/xilinx_pci.c

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
