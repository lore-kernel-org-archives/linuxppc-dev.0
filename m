Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fM4T0jzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:07 +1000 (AEST)
In-Reply-To: <1459415968-4890-2-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com
Subject: Re: [v3,2/2] cxl: Configure the PSL for two CAPI ports on POWER8NVL
Message-Id: <3qk8fM33l5z9t43@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-31-03 at 09:19:28 UTC, Philippe Bergheaud wrote:
> The POWER8NVL chip has two CAPI ports.  Configure the PSL to route
> data to the port corresponding to the CAPP unit.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aa14138a51ca42eada706d4b96

cheers
