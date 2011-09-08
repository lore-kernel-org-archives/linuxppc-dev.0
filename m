Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 17/62] powerpc: irq: Remove IRQF_DISABLED
Date: Thu, 8 Sep 2011 18:41:28 +0200
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-18-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-18-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201109081841.28487.arnd@arndb.de>
Cc: Meador Inge <meador_inge@mentor.com>, cbe-oss-dev@lists.ozlabs.org,
	Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>,
	Scott Wood <scottwood@freescale.com>, tglx@linutronix.de,
	linuxppc-dev@lists.ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 07 September 2011, Yong Zhang wrote:
> 
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> ---
>  arch/powerpc/include/asm/floppy.h              |    4 ++--
>  arch/powerpc/include/asm/xics.h                |    4 ++--
>  arch/powerpc/kernel/smp.c                      |    2 +-
>  arch/powerpc/platforms/cell/beat.c             |    2 +-
>  arch/powerpc/platforms/cell/celleb_scc_pciex.c |    2 +-
>  arch/powerpc/platforms/cell/iommu.c            |    3 +--
>  arch/powerpc/platforms/cell/pmu.c              |    2 +-
>  arch/powerpc/platforms/cell/spu_base.c         |    9 +++------

Acked-by: Arnd Bergmann <arnd@arndb.de>
