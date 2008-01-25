Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E553DE179
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 02:59:07 +1100 (EST)
Date: Fri, 25 Jan 2008 09:56:12 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH for-2.6.25] [POWERPC] Rename commproc to cpm1 and
	cpm2_common.c to cpm2.c
In-Reply-To: <4799F2CE.309@scram.de>
Message-ID: <Pine.LNX.4.64.0801250955580.16736@blarg.am.freescale.net>
References: <4799F2CE.309@scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, "Garzik, Jeff" <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008, Jochen Friedrich wrote:

> Rename commproc.[ch] to cpm1.[ch] to be more consistent with cpm2. Also
> rename cpm2_common.c to cpm2.c as suggested by Scott Wood. Adjust the
> includes accordingly.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/powerpc/platforms/8xx/ep88xc.c           |    1 +
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c  |    2 +-
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c  |    2 +-
>  arch/powerpc/sysdev/Makefile                  |    4 ++--
>  arch/powerpc/sysdev/{commproc.c => cpm1.c}    |    4 ++--
>  arch/powerpc/sysdev/{cpm2_common.c => cpm2.c} |    3 +--
>  arch/powerpc/sysdev/micropatch.c              |    2 +-
>  arch/ppc/8260_io/enet.c                       |    2 +-
>  arch/ppc/8xx_io/commproc.c                    |    2 +-
>  arch/ppc/8xx_io/enet.c                        |    6 +++---
>  arch/ppc/8xx_io/fec.c                         |    2 +-
>  arch/ppc/8xx_io/micropatch.c                  |    2 +-
>  arch/ppc/boot/simple/iic.c                    |    2 +-
>  arch/ppc/boot/simple/m8xx_tty.c               |    2 +-
>  arch/ppc/kernel/ppc_ksyms.c                   |    2 +-
>  arch/ppc/platforms/mpc866ads_setup.c          |    2 +-
>  arch/ppc/platforms/mpc885ads_setup.c          |    2 +-
>  arch/ppc/syslib/mpc8xx_devices.c              |    2 +-
>  arch/ppc/xmon/start_8xx.c                     |    2 +-
>  drivers/net/fec_8xx/fec_8xx-netta.c           |    2 +-
>  drivers/net/fec_8xx/fec_main.c                |    2 +-
>  drivers/net/fec_8xx/fec_mii.c                 |    2 +-
>  drivers/net/fs_enet/fs_enet.h                 |    2 +-
>  drivers/net/fs_enet/mac-fec.c                 |    2 +-
>  drivers/net/fs_enet/mac-scc.c                 |    2 +-
>  drivers/serial/cpm_uart/cpm_uart_cpm1.h       |    2 +-
>  include/asm-powerpc/{commproc.h => cpm1.h}    |    8 ++++----
>  include/asm-ppc/{commproc.h => cpm1.h}        |    8 ++++----
>  28 files changed, 38 insertions(+), 38 deletions(-)
>  rename arch/powerpc/sysdev/{commproc.c => cpm1.c} (99%)
>  rename arch/powerpc/sysdev/{cpm2_common.c => cpm2.c} (99%)
>  rename include/asm-powerpc/{commproc.h => cpm1.h} (99%)
>  rename include/asm-ppc/{commproc.h => cpm1.h} (99%)
>

applied.

- k
