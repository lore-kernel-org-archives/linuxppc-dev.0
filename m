Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F2E21A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 11:44:23 +1000 (AEST)
In-Reply-To: <1438153805-31828-2-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [2/8] powerpc/slb: Rename all the 'slot' occurrences to 'entry'
Message-Id: <20150813014423.3FB3E140342@ozlabs.org>
Date: Thu, 13 Aug 2015 11:44:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 07:09:59 UTC, Anshuman Khandual wrote:
> These are essentially SLB individual slots with entries what we are
> dealing with in these functions. Usage of both 'entry' and 'slot'
> synonyms makes it real confusing sometimes. This patch makes it
> uniform across the file by replacing all those 'slot's with 'entry's.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2be682af48e8236558da

cheers
