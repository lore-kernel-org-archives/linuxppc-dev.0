Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvN2x4hzDsTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:32 +1000 (AEST)
In-Reply-To: <1473139963-7496-4-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,4/5] powerpc/fadump: Make ELF eflags depend on endian
Message-Id: <3sYNvN0026z9t0w@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 05:32:42 UTC, Daniel Axtens wrote:
> Firmware Assisted Dump is a facility to dump kernel core with assistance
> from firmware.  As part of this process the kernel ELF version is
> stored.
> 
> Currently, fadump.h defines this to 0 if it is not already defined. This
> clashes with a define in elf.h which sets it based on the current task -
> not based on the kernel.
> 
> When the kernel is compiled on LE, the kernel will always be version
> 2. Otherwise it will be version 0. So the correct behaviour is to set
> the ELF eflags based on the endianness of the kernel. Do that.
> 
> Remove the definition in fadump.h, which becomes unused.
> 
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d8bced27be25537bde3714cbdb

cheers
