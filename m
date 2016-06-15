Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTwNj13qGzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:41:09 +1000 (AEST)
In-Reply-To: <1465404871-5406-8-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, benh@au1.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v6,
 07/11] powerpc/powernv: set power_save func after the idle states are
 initialized
Message-Id: <3rTwNj07nPz9t1J@ozlabs.org>
Date: Wed, 15 Jun 2016 15:41:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 16:54:27 UTC, "Shreyas B. Prabhu" wrote:
> pnv_init_idle_states discovers supported idle states from the
> device tree and does the required initialization. Set power_save
> function pointer only after this initialization is done

This looks like a bug fix? Or is this not a concern in practice for some reason
(and if so what is that reason)?

cheers
