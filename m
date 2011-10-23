Return-Path: <geoff@infradead.org>
Subject: Re: [PATCH 15/49] powerpc: irq: Remove IRQF_DISABLED
From: Geoff Levand <geoff@infradead.org>
To: Yong Zhang <yong.zhang0@gmail.com>
In-Reply-To: <1319277421-9203-16-git-send-email-yong.zhang0@gmail.com>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
 <1319277421-9203-16-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 22 Oct 2011 18:57:08 -0700
Message-ID: <1319335028.4949.1.camel@pump>
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-10-22 at 17:56 +0800, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/include/asm/floppy.h              |    4 ++--
>  arch/powerpc/include/asm/xics.h                |    4 ++--
>  arch/powerpc/kernel/smp.c                      |    2 +-
>  arch/powerpc/platforms/cell/beat.c             |    2 +-
>  arch/powerpc/platforms/cell/celleb_scc_pciex.c |    2 +-
>  arch/powerpc/platforms/cell/iommu.c            |    3 +--
>  arch/powerpc/platforms/cell/pmu.c              |    2 +-
>  arch/powerpc/platforms/cell/spu_base.c         |    9 +++------
>  arch/powerpc/platforms/powermac/pic.c          |    1 -
>  arch/powerpc/platforms/powermac/smp.c          |    4 ++--
>  arch/powerpc/platforms/ps3/device-init.c       |    2 +-
>  arch/powerpc/sysdev/mpic.c                     |    2 --
>  arch/powerpc/sysdev/ppc4xx_soc.c               |    2 +-
>  arch/powerpc/sysdev/xics/xics-common.c         |    5 ++---
>  14 files changed, 18 insertions(+), 26 deletions(-)

Looks OK for PS3.

Acked-by: Geoff Levand <geoff@infradead.org>
