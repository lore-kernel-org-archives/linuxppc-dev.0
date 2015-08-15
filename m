Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25CDE1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 13:51:18 +1000 (AEST)
Message-ID: <55CEB5CB.4060803@tabi.org>
Date: Fri, 14 Aug 2015 22:45:15 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Dongsheng Wang <dongsheng.wang@freescale.com>
CC: scottwood@freescale.com, Jason.Jin@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2] video: fbdev: fsl: Fix the sleep function for
 FSL DIU module
References: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1439531649-46827-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dongsheng Wang wrote:
> For deep sleep, the diu module will power off, when wake up
> from the deep sleep, the registers need to be reinitialized.
>
> Signed-off-by: Jason Jin<Jason.Jin@freescale.com>
> Signed-off-by: Wang Dongsheng<dongsheng.wang@freescale.com>

Acked-by: Timur Tabi <timur@tabi.org>
