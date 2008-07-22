Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 9D045DDF63
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 17:25:47 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so403887anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 00:25:46 -0700 (PDT)
Message-ID: <fa686aa40807220025r4e6f7c85xab03e4b7df154a70@mail.gmail.com>
Date: Tue, 22 Jul 2008 01:25:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull mpc5200-next
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

Hi Paul/Ben

Please pull my mpc5200 next branch for the following commits:

Thanks,
g.

The following changes since commit e89970aa93b06d0605a488e74af3b0a2a80e03b5:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Grant Likely (3):
      powerpc/mpc5200: Make mpc5200 GPIO driver select the GENERIC_GPIO config
      powerpc/mpc5200: add PSC SICR bit definitions
      of-bindings: Add binding documentation for SPI busses and devices

Jon Smirl (2):
      powerpc/mpc5200: Add AC97 register definitions for the MPC52xx PSC
      powerpc/mpc5200: Remove fsl-soc.c from mpc5200 build, it is not needed.

Wolfram Sang (1):
      powerpc/mpc5200: Fix wrong 'no interrupt' handling in of_i2c

 Documentation/powerpc/booting-without-of.txt |   57 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig          |    2 +-
 drivers/of/of_i2c.c                          |    2 -
 include/asm-powerpc/mpc52xx_psc.h            |   40 +++++++++++++++++-
 4 files changed, 95 insertions(+), 6 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
