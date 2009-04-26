Return-Path: <jonsmirl@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 57EE3DDE31
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 05:53:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1169244anc.39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 12:53:03 -0700 (PDT)
Subject: [PATCH V1 0/3] Split the DMA core out from mpc5200_psc_i2s.c
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sun, 26 Apr 2009 15:53:00 -0400
Message-ID: <20090426195215.4648.62017.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch series to separate out the mpc5200 core DMA routines from
mpc5200_psc_i2s.c into a standalone mpc5200_dma.c. No intention
to change how anything works, this is just a code reorg needed for
later patches to build on.

---

Jon Smirl (3):
      Rename exports in mpc5200_dma.c
      Rename the PSC functions to DMA
      Basic split of mpc5200 DMA code out from mpc5200_psc_i2s


 sound/soc/fsl/Kconfig           |    4
 sound/soc/fsl/Makefile          |    2
 sound/soc/fsl/mpc5200_dma.c     |  463 ++++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h     |   81 +++++
 sound/soc/fsl/mpc5200_psc_i2s.c |  644 +++++----------------------------------
 5 files changed, 632 insertions(+), 562 deletions(-)
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h

--
Jon Smirl
jonsmirl@gmail.com
