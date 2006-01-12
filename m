Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 99A836893F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 04:32:23 +1100 (EST)
Message-ID: <43C691C2.9090607@ru.mvista.com>
Date: Thu, 12 Jan 2006 20:28:34 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca
References: <1136795579525-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1136795579525-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 02/10] Make Virtex-II Pro support generic for all Virtex
 devices
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

grant.likely@secretlab.ca wrote:
> The PPC405 hard core is used in both the Virtex-II Pro and Virtex 4 FX
> FPGAs.  This patch cleans up the Virtex naming convention to reflect more
> than just the Virtex-II Pro.
> 
> Rename files virtex-ii_pro.[ch] to virtex.[ch]
> Rename config value VIRTEX_II_PRO to XILINX_VIRTEX
> 
> Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>
> 
> ---

Here is a misprint:
> 
...
> diff --git a/arch/ppc/platforms/4xx/virtex.c b/arch/ppc/platforms/4xx/virtex.c
> new file mode 100644
> index 0000000..1de7a27
> --- /dev/null
> +++ b/arch/ppc/platforms/4xx/virtex.c
> @@ -0,0 +1,60 @@
> +/*
> + * arch/ppc/platforms/4xx/virtex.c
> + *
> + * Author: MontaVista Software, Inc.
> + *         source@mvista.com
> + *
> + * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
> + * terms of the GNU General Public License version 2.  This program is licensed
> + * "as is" without any warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <asm/ocp.h>
> +#include <platform/4xx/virtex.h>

Should be
#include <platforms/4xx/virtex.h>

Otherwise tested OK on ML300
