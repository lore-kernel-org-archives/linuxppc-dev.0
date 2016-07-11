Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Ks55X1zDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:29 +1000 (AEST)
In-Reply-To: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, fbarrat@linux.vnet.ibm.com, tgrobeck@us.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [v2] cxl: Ignore CAPI adapters misplaced in switched slots
Message-Id: <3rp1Ks3JQQz9t18@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-01-07 at 11:32:52 UTC, Philippe Bergheaud wrote:
> One should not attempt to switch a PHB into CAPI mode if there is
> a switch between the PHB and the adapter. This patch modifies the
> cxl driver to ignore CAPI adapters misplaced in switched slots.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b3dcd61fa4e3604d8f1bdfd84

cheers
