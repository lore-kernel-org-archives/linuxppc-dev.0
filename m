Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 679801A0C92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 14:09:31 +1100 (AEDT)
Message-ID: <1446692954.12676.42.camel@freescale.com>
Subject: Re: [PATCH V3 1/2] powerpc/fsl: Add PCI node in device tree of
 bsc9132qds
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <devicetree@vger.kernel.org>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
 <mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
 <harninder.rai@freescale.com>, <Minghuan.Lian@freescale.com>,
 <Mingkai.Hu@freescale.com>, Hou Zhiqiang <B48286@freescale.com>
Date: Wed, 4 Nov 2015 21:09:14 -0600
In-Reply-To: <1446691975-8965-1-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1446691975-8965-1-git-send-email-Zhiqiang.Hou@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-05 at 10:52 +0800, Zhiqiang Hou wrote:
> From: Harninder Rai <harninder.rai@freescale.com>
> 
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
> Reviewed-by: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
> V3:
>  - Remove gerrit stuff.

No, you didn't remove all of the Gerrit stuff.  Get rid of all the Reviewed-
by and Tested-by since they are not relevant to this context.  Hitting "+1" 
in Gerrit to allow a patch to go into the SDK tree a few years ago is not the 
same as reviewing it for inclusion in mainline Linux today.

-Scott
