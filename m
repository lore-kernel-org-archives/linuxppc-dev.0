Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ED011A0C6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:37:09 +1100 (AEDT)
In-Reply-To: <20141203110315.25444.88272.stgit@localhost.localdomain>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/2] pstore: add pstore support on powernv
Message-Id: <20141204053708.E24341400EA@ozlabs.org>
Date: Thu,  4 Dec 2014 16:37:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 11:03:15 UTC, Hari Bathini wrote:
> This patch extends pstore, a generic interface to platform dependent
> persistent storage, support for powernv  platform to capture certain
> useful information, during dying moments. Such support is already in
> place for  pseries platform.  This patch while adding pstore support
> for  powernv platform,  moves common code for pseries and powernv to
> arch/powerpc/kernel/nvram_64.c file.

Please move the common code first in a separate patch. Unless there's some
reason you absolutely can't do that.

cheers
