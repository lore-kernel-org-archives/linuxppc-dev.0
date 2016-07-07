Return-Path: <jason@lakedaemon.net>
Received: from outbound1a.ore.mailhop.org (outbound1a.ore.mailhop.org
 [54.213.22.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlg0G1Ld9zDqyg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 00:26:05 +1000 (AEST)
Date: Thu, 7 Jul 2016 14:24:58 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, tglx@linutronix.de, marc.zyngier@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xiaobo.xie@nxp.com
Subject: Re: [PATCH v2] irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
Message-ID: <20160707142458.GN3348@io.lakedaemon.net>
References: <1467854635-19208-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467854635-19208-1-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhao Qiang,

On Thu, Jul 07, 2016 at 09:23:55AM +0800, Zhao Qiang wrote:
> The driver stays the same.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- modify the subject and commit msg
> 
>  drivers/irqchip/Makefile                | 1 +
>  drivers/{soc/fsl/qe => irqchip}/qe_ic.c | 0
>  drivers/{soc/fsl/qe => irqchip}/qe_ic.h | 0
>  drivers/soc/fsl/qe/Makefile             | 2 +-
>  4 files changed, 2 insertions(+), 1 deletion(-)
>  rename drivers/{soc/fsl/qe => irqchip}/qe_ic.c (100%)
>  rename drivers/{soc/fsl/qe => irqchip}/qe_ic.h (100%)

Please merge the include file into the C file and rename to follow the
naming convention in drivers/irqchip/.  e.g. irq-qeic.c or irq-qe_ic.c.

Once you have that, please resend the entire series with this as the
first patch.

thx,

Jason.
