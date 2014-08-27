Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DFDD1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 21:19:23 +1000 (EST)
Message-ID: <53FDBEB7.4090909@suse.de>
Date: Wed, 27 Aug 2014 13:19:19 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] powerpc/booke: Restrict SPE exception handlers
 to e200/e500 cores
References: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=windows-1252
Cc: Scott Wood <scottwood@freescale.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20.08.14 15:09, Mihai Caraman wrote:
> SPE exception handlers are now defined for 32-bit e500mc cores even though
> SPE unit is not present and CONFIG_SPE is undefined.
> 
> Restrict SPE exception handlers to e200/e500 cores adding CONFIG_SPE_POSSIBLE
> and consequently guard __stup_ivors and __setup_cpu functions.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Alexander Graf <agraf@suse.de>

Thanks, applied both to kvm-ppc-queue.


Alex
