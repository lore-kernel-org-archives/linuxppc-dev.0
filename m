Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id AAF3CDDE44
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 08:34:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so882273anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 13:34:25 -0800 (PST)
Message-ID: <fa686aa40802061334u5700bbf3ua3bbf6d967c9b2cc@mail.gmail.com>
Date: Wed, 6 Feb 2008 14:34:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>,
	"Rigby John-R61273" <jrigby@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Fwd: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <fa686aa40802061333kd6567bay92c530bb08a2aac8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40802061333kd6567bay92c530bb08a2aac8@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(resend; including the mailing list this time)

Paul,

Please pull my mpc52xx tree.  It contains the MPC512x work which John
Rigby has been doing.  I should have got these out to you sooner, but
I forgot about them.  :-(

Cheers,
g.

The following changes since commit 99e139126ab2e84be67969650f92eb37c12ab5cd:
  Michael Ellerman (1):
        [POWERPC] Cell IOMMU fixed mapping support

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

John Rigby (4):
      [POWERPC] mpc512x: Basic platform support
      [POWERPC] mpc512x: Device tree for MPC5121 ADS
      [POWERPC] mpc512x: Factor out 5200 dependencies from 52xx psc driver
      [POWERPC] mpc512x: Add MPC512x PSC support to MPC52xx psc driver

 arch/powerpc/Kconfig                      |    2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts      |  122 ++++++++
 arch/powerpc/platforms/512x/Kconfig       |   20 ++
 arch/powerpc/platforms/512x/Makefile      |    4 +
 arch/powerpc/platforms/512x/mpc5121_ads.c |  104 +++++++
 arch/powerpc/platforms/Kconfig            |    1 +
 arch/powerpc/platforms/Kconfig.cputype    |    6 +-
 arch/powerpc/platforms/Makefile           |    1 +
 drivers/serial/Kconfig                    |   12 +-
 drivers/serial/mpc52xx_uart.c             |  431 ++++++++++++++++++++++++-----
 include/asm-powerpc/mpc512x.h             |   22 ++
 include/asm-powerpc/mpc52xx_psc.h         |   48 ++++
 12 files changed, 694 insertions(+), 79 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts
 create mode 100644 arch/powerpc/platforms/512x/Kconfig
 create mode 100644 arch/powerpc/platforms/512x/Makefile
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.c
 create mode 100644 include/asm-powerpc/mpc512x.h


--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
