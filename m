Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6C8852C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:25:43 +1000 (EST)
Subject: Re: [PATCH v8 4/7] powerpc/85xx: add HOTPLUG_CPU support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342788159-27529-5-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 31 Jul 2012 09:24:46 -0500
Message-Id: <6D7449F5-A4C4-4E3F-AD47-CC103B9044ED@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <1342788159-27529-5-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 7:42 AM, Zhao Chenhui wrote:

> Add support to disable and re-enable individual cores at runtime
> on MPC85xx/QorIQ SMP machines. Currently support e500v1/e500v2 core.
>=20
> MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
> This patch uses the boot page from bootloader to boot core at runtime.
> It supports 32-bit and 36-bit physical address.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> arch/powerpc/Kconfig                  |    6 ++-
> arch/powerpc/include/asm/cacheflush.h |    2 +
> arch/powerpc/include/asm/smp.h        |    1 +
> arch/powerpc/kernel/head_fsl_booke.S  |   28 ++++++++++
> arch/powerpc/platforms/85xx/smp.c     |   90 =
++++++++++++++++++++++++++++-----
> 5 files changed, 112 insertions(+), 15 deletions(-)

applied to next

- k=
