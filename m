Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0133.outbound.protection.outlook.com [157.56.111.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EB161A01FF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jan 2015 19:58:01 +1100 (AEDT)
Message-ID: <54A65A09.6070705@Freescale.com>
Date: Fri, 2 Jan 2015 02:42:49 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: <shh.xie@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@Freescale.com>
Subject: Re: [PATCH 2/2] powerpc/config: enable mdio buses muxing via
 Memory-mapped device
References: <1419240062-29559-1-git-send-email-shh.xie@gmail.com>
In-Reply-To: <1419240062-29559-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="utf-8"
Cc: Andy Fleming <afleming@gmail.com>,
 Kanetkar Shruti-B44454 <Shruti@Freescale.com>,
 Shaohui Xie <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shao-Hui,


On 12/22/2014 03:21 AM, shh.xie@gmail.com wrote:
> From: Andy Fleming <afleming@gmail.com>
> 
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig | 1 +
>  arch/powerpc/configs/corenet64_smp_defconfig | 1 +
>  2 files changed, 2 insertions(+)

Shruti submitted a more complete version of this patch here:

http://patchwork.ozlabs.org/patch/370873

We should stick with that version


Cheers,
