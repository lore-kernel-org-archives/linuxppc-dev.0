Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75AFFDE025
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 01:46:41 +1100 (EST)
Message-Id: <CE8D99D3-F02C-4D7B-B2A0-3CEAD2BEB9F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080220183338.GA9282@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Fix wrapper platform for adder875, and combine defconfigs.
Date: Fri, 7 Mar 2008 08:46:34 -0600
References: <20080220183338.GA9282@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 20, 2008, at 12:33 PM, Scott Wood wrote:

> This fixes the following bug:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051979.html
>
> Separate defconfigs are no longer needed now that CONFIG_DEVICE_TREE  
> is gone.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/wrapper                          |    6 +-
> arch/powerpc/configs/adder875-uboot_defconfig      |  798  
> --------------------
> ...der875-redboot_defconfig => adder875_defconfig} |   61 +-
> 3 files changed, 43 insertions(+), 822 deletions(-)
> delete mode 100644 arch/powerpc/configs/adder875-uboot_defconfig
> rename arch/powerpc/configs/{adder875-redboot_defconfig =>  
> adder875_defconfig} (95%)

applied.

- k
