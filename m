Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTWJD4g80zDvpJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 06:51:24 +1100 (AEDT)
In-Reply-To: <1480423554-6411-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 akpm@linux-foundation.org, dyoung@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [v11, 1/8] kexec_file: Allow arch-specific memory walking for
 kexec_add_buffer
Message-Id: <3tTWJD3SqTz9sfH@ozlabs.org>
Date: Thu,  1 Dec 2016 06:51:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-29 at 12:45:47 UTC, Michael Ellerman wrote:
> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> Allow architectures to specify a different memory walking function for
> kexec_add_buffer. x86 uses iomem to track reserved memory ranges, but
> PowerPC uses the memblock subsystem.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/60fe3910bb029e3671ce7ac080a7ac

cheers
