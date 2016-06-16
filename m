Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVkJK3PxZzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 23:10:09 +1000 (AEST)
In-Reply-To: <1462975853-28904-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, mikey@neuling.org,
 imunsie@au1.ibm.com
Subject: Re: cxl: Refine slice error debug messages.
Message-Id: <3rVkJK2QVbz9t0M@ozlabs.org>
Date: Thu, 16 Jun 2016 23:10:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-05 at 14:10:53 UTC, Philippe Bergheaud wrote:
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

This conflicted with "cxl: Abstract the differences between the PSL and XSL" so I dropped this.

Please rebase and resend if you still want it to go in.

cheers
