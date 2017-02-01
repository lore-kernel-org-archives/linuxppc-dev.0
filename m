Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL44mkgzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:32 +1100 (AEDT)
In-Reply-To: <1481683011-12819-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [v3] powerpc/powernv: Initialise nest mmu
Message-Id: <3vClL43Sr7z9tk2@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-12-14 at 02:36:51 UTC, Alistair Popple wrote:
> POWER9 contains an off core mmu called the nest mmu (NMMU). This is
> used by other hardware units on the chip to translate virtual
> addresses into real addresses. The unit attempting an address
> translation provides the majority of the context required for the
> translation request except for the base address of the partition table
> (ie. the PTCR) which needs to be programmed into the NMMU.
> 
> This patch adds a call to OPAL to set the PTCR for the nest mmu in
> opal_init().
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1d0761d2557d1540727723e4f05395

cheers
