Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RG54dkczDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:41 +1100 (AEDT)
In-Reply-To: <1516157443-17716-2-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
Subject: Re: [1/5] powerpc/vas: Remove a stray line in Makefile
Message-Id: <401RG43HWbz9sVQ@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-17 at 02:50:39 UTC, Sukadev Bhattiprolu wrote:
> Remove a bogus line from arch/powerpc/platforms/powernv/Makefile that
> was added by commit ece4e51 ("powerpc/vas: Export HVWC to debugfs").
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2f65272a2a304ec6aa32ad9a45b150

cheers
