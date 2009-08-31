Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 16BEFB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 02:24:27 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7VGNr6Y018658
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2009 12:23:53 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7VGOJmf239216
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2009 12:24:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7VGOJSc024644
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2009 12:24:19 -0400
Date: Mon, 31 Aug 2009 12:24:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20090831162412.GD32320@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Please pull the 'next' branch of the 4xx tree to get the following changes.

Thanks,
josh

The following changes since commit 77c0a700c1c292edafa11c1e52821ce4636f81b0:
  Benjamin Herrenschmidt (1):
        powerpc: Properly start decrementer on BookE secondary CPUs

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Solomon Peachy (1):
      powerpc/40x: Add support for the ESTeem 195E (PPC405EP) SBC

Stefan Roese (2):
      powerpc/44x: Update Arches dts
      powerpc/44x: Update Arches defconfig

Tiejun Chen (2):
      powerpc/405ex: provide necessary fixup function to support cuImage
      powerpc/405ex: support cuImage via included dtb

fkan@amcc.com (1):
      powerpc/44x: Add Eiger AMCC (AppliedMicro) PPC460SX evaluation board support.

 arch/powerpc/boot/4xx.c                    |  142 ++++
 arch/powerpc/boot/4xx.h                    |    1 +
 arch/powerpc/boot/Makefile                 |    6 +-
 arch/powerpc/boot/cuboot-hotfoot.c         |  142 ++++
 arch/powerpc/boot/cuboot-kilauea.c         |   49 ++
 arch/powerpc/boot/dcr.h                    |    4 +-
 arch/powerpc/boot/dts/arches.dts           |   50 ++
 arch/powerpc/boot/dts/eiger.dts            |  421 ++++++++++
 arch/powerpc/boot/dts/hotfoot.dts          |  294 +++++++
 arch/powerpc/boot/ppcboot-hotfoot.h        |  133 +++
 arch/powerpc/configs/44x/arches_defconfig  |  382 ++++++++--
 arch/powerpc/configs/44x/eiger_defconfig   | 1252 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/Kconfig         |   10 +
 arch/powerpc/platforms/40x/ppc40x_simple.c |    3 +-
 arch/powerpc/platforms/44x/Kconfig         |   12 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 16 files changed, 2846 insertions(+), 56 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-hotfoot.c
 create mode 100644 arch/powerpc/boot/cuboot-kilauea.c
 create mode 100644 arch/powerpc/boot/dts/eiger.dts
 create mode 100644 arch/powerpc/boot/dts/hotfoot.dts
 create mode 100644 arch/powerpc/boot/ppcboot-hotfoot.h
 create mode 100644 arch/powerpc/configs/44x/eiger_defconfig
