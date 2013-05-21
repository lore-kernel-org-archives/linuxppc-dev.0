Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33F4C2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:05:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/3] several cleanup patches for fsl pci
Date: Tue, 21 May 2013 20:04:57 +0800
Message-ID: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are against Linus's tree and passed the boot test on
T4240qds board.

Kevin Hao (3):
  powerpc/mpc85xx: remove the unneeded pci init functions for corenet ds
        board
  powerpc/fsl-pci: fix the unreachable warning message
  powerpc/fsl-pci: enable SWIOTLB in function setup_pci_atmu

 arch/powerpc/platforms/85xx/corenet_ds.c |  6 ------
 arch/powerpc/sysdev/fsl_pci.c            | 24 ++++--------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

-- 
1.8.1.4
