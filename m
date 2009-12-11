Return-Path: <dan.j.williams@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 536EDB7BC1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 17:22:30 +1100 (EST)
Message-ID: <4B21E524.4010601@intel.com>
Date: Thu, 10 Dec 2009 23:22:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3] ppc440spe-adma: adds updated ppc440spe adma driver
References: <1259858161-15315-1-git-send-email-agust@denx.de>
In-Reply-To: <1259858161-15315-1-git-send-email-agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "wd@denx.de" <wd@denx.de>, "dzu@denx.de" <dzu@denx.de>,
	Yuri Tikhonov <yur@emcraft.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:
> This patch adds new version of the PPC440SPe ADMA driver.
> 
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> 
> Changes since v2:
>  - Correct Sign-offs order.
>  - Place the driver in 'drivers/dma/ppc4xx' directory
>    as there are wishes to extend the driver to support
>    other CPUs (PPC460EX) later.
>  - Don't duplicate directory name in the driver file names.
>  - Perform checks for 'len' > PAGE_SIZE cases while
>    looking for suitable channel for async operations
>    so that there will be a fallback to synchronous path
>    if a user of the api should ever submit pq_val requests
>    with 'len' > PAGE_SIZE.
> 

Ok, please split the katmai.dts fixups to a separate patch to send to 
Josh as this patch has picked up new conflicts with his tree.  It also 
appears that this is not based on my next branch [1] because the 
Makefile and Kconfig updates collide with the coh driver.  Fix that up 
and I'll apply this for my pull request for 2.6.33.

Thanks,
Dan

[1] git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next
