Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id BCBAA102079
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:12:22 +1100 (EST)
Received: by pwi10 with SMTP id 10so174708pwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:12:21 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] Stuff to make of_device more like platform_device
To: monstr@monstr.eu, benh@kernel.crashing.org, sfr@canb.auug.org.au,
	jeremy.kerr@canonical.com, microblaze-uclinux@itee.uq.edu.au,
	linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
Date: Thu, 11 Mar 2010 11:12:18 -0700
Message-ID: <20100311180952.13022.82694.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches make it possible to use struct platform_device as a drop
in replacement for struct of_device, which is a stepping stone to
removing the duplication between the platform bus and the of bus.

g.

---

Grant Likely (2):
      arch/microblaze: Move dma_mask from of_device into pdev_archdata
      arch/powerpc: Move dma_mask from of_device into pdev_archdata


 arch/microblaze/include/asm/device.h    |    1 +
 arch/microblaze/include/asm/of_device.h |    2 +-
 arch/microblaze/kernel/of_device.c      |    2 +-
 arch/microblaze/kernel/of_platform.c    |    2 +-
 arch/powerpc/include/asm/device.h       |    1 +
 arch/powerpc/include/asm/of_device.h    |    2 +-
 arch/powerpc/kernel/of_device.c         |    2 +-
 arch/powerpc/kernel/of_platform.c       |    2 +-
 drivers/macintosh/macio_asic.c          |    4 ++--
 sound/aoa/soundbus/i2sbus/core.c        |    4 ++--
 10 files changed, 12 insertions(+), 10 deletions(-)

-- 
Signature
