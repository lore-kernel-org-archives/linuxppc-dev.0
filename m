Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqt2G7HzF0X1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:18 +1100 (AEDT)
In-Reply-To: <1513742157-28768-3-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, npiggin@gmail.com,
 paulus@samba.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v10, 02/17] powerpc/64: Add #defines for paca->soft_enabled flags
Message-Id: <3zPxqs262zz9sCZ@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-20 at 03:55:42 UTC, Madhavan Srinivasan wrote:
> Two #defines, IRQ_ENABLED and IRQ_DISABLED, are added to be used when
> updating paca->soft_enabled. Replace the hardcoded values used when
> updating paca->soft_enabled with IRQ_[EN/DIS]ABLED. No logic change.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Patchs 2-17 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2e480ba822718190e58849b79a76d

cheers
