Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 732F5DDFAF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 14:00:45 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1195038anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 21:00:44 -0700 (PDT)
Message-ID: <fa686aa40807252100q299f87d7xc2101869a45704bb@mail.gmail.com>
Date: Sat, 26 Jul 2008 00:00:43 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: Please pull mpc52xx-next
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

Hey Ben, here are a few more patches for .27.  I would have had this
stuff in earlier, but they depended on another patch that I didn't
feel like I should push that was in Andrew's queue.

Thanks,
g.

The following changes since commit 1ff8419871ea757ae0298aa296bcff9b2ca48561:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git next

Grant Likely (4):
      of: adapt of_find_i2c_driver() to be usable by SPI also
      spi: split up spi_new_device() to allow two stage registration.
      spi: Add OF binding support for SPI busses
      powerpc/mpc5200: Add mpc5200-spi (non-PSC) device driver

 drivers/of/Kconfig              |    6 +
 drivers/of/Makefile             |    1 +
 drivers/of/base.c               |   88 ++++++
 drivers/of/of_i2c.c             |   64 +----
 drivers/of/of_spi.c             |   93 ++++++
 drivers/spi/Kconfig             |    8 +
 drivers/spi/Makefile            |    1 +
 drivers/spi/mpc52xx_spi.c       |  602 +++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c               |  139 ++++++---
 include/linux/of.h              |    1 +
 include/linux/of_spi.h          |   18 ++
 include/linux/spi/mpc52xx_spi.h |   10 +
 include/linux/spi/spi.h         |   12 +
 13 files changed, 938 insertions(+), 105 deletions(-)
 create mode 100644 drivers/of/of_spi.c
 create mode 100644 drivers/spi/mpc52xx_spi.c
 create mode 100644 include/linux/of_spi.h
 create mode 100644 include/linux/spi/mpc52xx_spi.h


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
