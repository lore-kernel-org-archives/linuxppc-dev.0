Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A7CCCB7CEF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 00:46:23 +1100 (EST)
Date: Mon, 1 Mar 2010 14:46:19 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 06/11] dma: Add MPC512x DMA driver
Message-ID: <20100301144619.71a6ceab@wker>
In-Reply-To: <1265377377-29327-7-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-7-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dan,

any chance this patch could be merged for 2.6.34 ?

Thanks,
Anatolij

On Fri,  5 Feb 2010 14:42:52 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> From: Piotr Ziecik <kosmo@semihalf.com>
> 
> Adds initial version of MPC512x DMA driver.
> Only memory to memory transfers are currenly supported.
> 
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> No changes since v2
> 
> Changes since v1:
>  - move content of the mpc512x.h into the drivers .c file as
>    it is only used by this DMA driver
>  - use __devinit/__devexit/__devexit_p as requested
>  - add unregistration of the dma device
>  - remove meaningless comment
> 
> Changes since patch version submitted in May 2009:
>  - don't use wildcards in compatible property, use "fsl,mpc5121-dma"
>  - don't add "fsl,mpc5121-dma" compatible to of_bus_ids[] as the
>    dma device is part of IMMR
> 
>  drivers/dma/Kconfig       |    7 +
>  drivers/dma/Makefile      |    1 +
>  drivers/dma/mpc512x_dma.c |  800 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 808 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/mpc512x_dma.c
