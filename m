Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76B8B1A0671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
In-Reply-To: <1438153805-31828-5-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [5/8] powerpc/slb: Add documentation to runtime patching of SLB
 encoding
Message-Id: <20150813014424.0CC79140662@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:10:02 UTC, Anshuman Khandual wrote:
> This patch adds some documentation to 'patch_slb_encoding' function
> explaining about how it clears the existing immediate value in the
> given instruction and inserts a new one there.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/79d0be7407955a268bce

cheers
