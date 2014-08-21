Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B1641A1798
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 11:58:33 +1000 (EST)
Message-ID: <1408586298.4058.97.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 2/2] powerpc/booke: Revert SPE/AltiVec common defines
 for interrupt numbers
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 20 Aug 2014 20:58:18 -0500
In-Reply-To: <1408540144-24436-2-git-send-email-mihai.caraman@freescale.com>
References: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
 <1408540144-24436-2-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-20 at 16:09 +0300, Mihai Caraman wrote:
> Book3E specification defines shared interrupt numbers for SPE and AltiVec
> units. Still SPE is present in e200/e500v2 cores while AltiVec is present in
> e6500 core. So we can currently decide at compile-time which unit to support
> exclusively. As Alexander Graf suggested, this will improve code readability
> especially in KVM.
> 
> Use distinct defines to identify SPE/AltiVec interrupt numbers, reverting
> c58ce397 and 6b310fc5 patches that added common defines.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kernel/exceptions-64e.S | 4 ++--
>  arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
