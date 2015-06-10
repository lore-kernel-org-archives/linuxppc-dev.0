Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15E8B1A0E41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 05:08:29 +1000 (AEST)
Message-ID: <1433962332.2477.118.camel@freescale.com>
Subject: Re: [PATCH 00/12] Freescale DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: <madalin.bucur@freescale.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Igal.Liberman <igal.liberman@freescale.com>
Date: Wed, 10 Jun 2015 13:52:12 -0500
In-Reply-To: <1433949712-5648-1-git-send-email-madalin.bucur@freescale.com>
References: <1433949712-5648-1-git-send-email-madalin.bucur@freescale.com>
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

On Wed, 2015-06-10 at 18:21 +0300, Madalin Bucur wrote:
> The Freescale Data Path Acceleration Architecture (DPAA)
> is a set of hardware components on specific QorIQ multicore
> processors. This architecture provides the infrastructure to
> support simplified sharing of networking interfaces and
> accelerators by multiple CPU cores and the accelerators.
> 
> One of the DPAA accelerators is the Frame Manager (FMan)
> which contains a series of hardware blocks: ports, Ethernet
> MACs, a multi user RAM (MURAM) and Storage Profile (SP).
> 
> This patch set introduced the FMan driver code that configures
> and initializes the FMan hardware blocks, offering support for
> three different types of MACs (DTSEC, TGEC, MEMAC).
> 
> The first 6 patches present the FMan Foundation Libraries (FLIBs).
> The FMan drivers make use of the basic API the FMan FLib provides
> to configure and control the FMan hardware. The remaining patches
> present the required FMan hardware module drivers.
> 
> The driver structure and a hint on file naming:
>  --------------------------------
> >      FMan MAC driver           |    mac* files
>  ------ ------ ----- ------- ----
> > FMan | Port | MAC | MURAM | SP |    fm_* files
>  ------ ------ ----- ------- ----
> :      : FLib :     :                 fman_* files
>  -------------------
> 
> This submission is based on the prior Freescale DPAA FMan V3,RFC
> submission. Several issues addresses in this submission:
>       - Reduced MAC layering and complexity
>       - Reduced code base
>       - T1024/T2080 10G best effort support

How is this different from the patchset Igal posted 7 hours earlier?

Please don't use the chained reply option in git send-email (and the 
patches are in the wrong order, which makes the chained reply 
especially bad).

I don't see any mention of a dependency on the qbman patches.
Where is the actual ethernet driver -- the part that sends and 
receives packets?

-Scott
