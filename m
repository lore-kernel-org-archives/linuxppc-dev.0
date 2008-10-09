Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id E8F96DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 19:02:42 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4197625rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 01:02:41 -0700 (PDT)
Message-ID: <fa686aa40810090102wcc8acf0i4577f195ca40eac6@mail.gmail.com>
Date: Thu, 9 Oct 2008 02:02:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull 'next' branch of
	git://git.secretlab.ca/git/linux-2.6-mpc52xx
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Can you please pull my mpc52xx support tree?

Thanks,
g.

The following changes since commit 7c12d906f4ef690c65e60111375856640f63a545:
  Benjamin Herrenschmidt (1):
        powerpc: Fix sysfs pci mmap on 32-bit machines with 64-bit PCI

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Anton Vorontsov (1):
      OF: add fsl,mcu-mpc8349emitx to the exception list

Grant Likely (1):
      powerpc/mpc5200: fix build warnings on mpc52xx_psc_spi driver

Tony Breeds (1):
      powerpc/mpc5200: Silence warnings in
arch/powerpc/platforms/52xx/mpc52xx_pci.c

Wolfgang Grandegger (1):
      i2c-mpc: suppress I2C device probing

Wolfram Sang (1):
      powerpc/mpc5200: trivial printk-fixes in mpc52xx_common

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    5 +++--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |   13 +++++++++----
 drivers/i2c/busses/i2c-mpc.c                 |    1 -
 drivers/of/base.c                            |    2 +-
 drivers/spi/mpc52xx_psc_spi.c                |    6 +++---
 5 files changed, 16 insertions(+), 11 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
