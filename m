Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id C4BB6DF291
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:39:03 +1000 (EST)
Date: Thu, 26 Jun 2008 17:36:53 +0300
From: Adrian Bunk <bunk@kernel.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 07/60] microblaze_v4: Support for semaphores
Message-ID: <20080626143652.GD30954@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1214483429-32360-8-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:29:36PM +0200, monstr@seznam.cz wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  include/asm-microblaze/semaphore.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-microblaze/semaphore.h
> 
> diff --git a/include/asm-microblaze/semaphore.h b/include/asm-microblaze/semaphore.h
> new file mode 100644
> index 0000000..d9b2034
> --- /dev/null
> +++ b/include/asm-microblaze/semaphore.h
> @@ -0,0 +1 @@
> +#include <linux/semaphore.h>

In -next all asm/semaphore.h headers gained a
  #warning Use linux/semaphore.h, not asm/semaphore.h
and the number of asm/semaphore.h is approaching zero.

You can simply drop this patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
