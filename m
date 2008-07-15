Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8CBBDEEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:22:37 +1000 (EST)
Message-Id: <8EF61F43-31AE-45CB-BC95-39175FEA2CE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1214500077-9254-3-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/2] powerpc: Move mpc83xx_add_bridge to fsl_pci.c [rev2]
Date: Tue, 15 Jul 2008 08:22:29 -0500
References: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
	<1214500077-9254-2-git-send-email-jrigby@freescale.com>
	<1214500077-9254-3-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 12:07 PM, John Rigby wrote:

> This allows other platforms with the same pci
> block like MPC5121 to use it.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> arch/powerpc/platforms/83xx/Kconfig       |    2 +-
> arch/powerpc/platforms/83xx/Makefile      |    1 -
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc83xx.h     |    1 -
> arch/powerpc/platforms/83xx/pci.c         |   91  
> -----------------------------
> arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
> arch/powerpc/sysdev/fsl_pci.c             |   61 +++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h             |    1 +
> 15 files changed, 72 insertions(+), 94 deletions(-)
> delete mode 100644 arch/powerpc/platforms/83xx/pci.c

applied.

- k
