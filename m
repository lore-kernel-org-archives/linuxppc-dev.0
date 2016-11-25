Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0024.hostedemail.com
 [216.40.44.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQNkK5dWHzDw1J
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 04:44:41 +1100 (AEDT)
Message-ID: <1480095870.19726.31.camel@perches.com>
Subject: Re: [PATCH] powerpc: Use pr_warn instead of pr_warning
From: Joe Perches <joe@perches.com>
To: Anatolij Gustschin <agust@denx.de>, Scott Wood <oss@buserror.net>, Kumar
 Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Nov 2016 09:44:30 -0800
In-Reply-To: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
References: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-10-24 at 21:00 -0700, Joe Perches wrote:
> At some point, pr_warning will be removed so all logging messages use
> a consistent <prefix>_warn style.
> 
> Update arch/powerpc/
> 
> Miscellanea:
> 
> o Coalesce formats
> o Realign arguments
> o Use %s, __func__ instead of embedded function names
> o Remove unnecessary line continuations

Ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/kernel/pci-common.c                |  4 ++--
>  arch/powerpc/mm/init_64.c                       |  5 ++---
>  arch/powerpc/mm/mem.c                           |  3 +--
>  arch/powerpc/platforms/512x/mpc512x_shared.c    |  4 ++--
>  arch/powerpc/platforms/85xx/socrates_fpga_pic.c |  7 +++----
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c      |  2 +-
>  arch/powerpc/platforms/pasemi/dma_lib.c         |  4 ++--
>  arch/powerpc/platforms/powernv/opal.c           |  8 ++++----
>  arch/powerpc/platforms/powernv/pci-ioda.c       | 10 +++++-----
>  arch/powerpc/platforms/ps3/device-init.c        | 12 +++++-------
>  arch/powerpc/platforms/ps3/mm.c                 |  4 ++--
>  arch/powerpc/platforms/ps3/os-area.c            |  2 +-
>  arch/powerpc/platforms/pseries/iommu.c          |  8 +++-----
>  arch/powerpc/platforms/pseries/setup.c          |  4 ++--
>  arch/powerpc/sysdev/fsl_pci.c                   |  9 +++------
>  arch/powerpc/sysdev/mpic.c                      | 10 ++++------
>  arch/powerpc/sysdev/xics/icp-native.c           | 10 ++++------
>  arch/powerpc/sysdev/xics/ics-opal.c             |  4 +--
>  arch/powerpc/sysdev/xics/ics-rtas.c             |  4 ++--
>  arch/powerpc/sysdev/xics/xics-common.c          |  8 ++++----
>  20 files changed, 54 insertions(+), 68 deletions(-)
> 
