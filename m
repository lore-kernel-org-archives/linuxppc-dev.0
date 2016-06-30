Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJvC4KZmzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:39 +1000 (AEST)
In-Reply-To: <1466750827-3062-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [RESEND, v7,
 2/2] cxl: Add set and get private data to context struct
Message-Id: <3rgJvC2TBbz9t0T@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-24-06 at 06:47:07 UTC, Philippe Bergheaud wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> This provides AFU drivers a means to associate private data with a cxl
> context. This is particularly intended for make the new callbacks for
> driver specific events easier for AFU drivers to use, as they can easily
> get back to any private data structures they may use.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ad42de859ff14c079e966e61cb

cheers
