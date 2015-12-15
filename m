Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AEC61A0B12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:13 +1100 (AEDT)
In-Reply-To: <1448419585-5181-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc: Append linux_banner to exception information in
 xmon.
Message-Id: <20151215112712.E210A140B93@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-11 at 02:46:25 UTC, Rashmica Gupta wrote:
> Currently if you are in xmon without an oops etc. to view the kernel
> version you have to type "d $linux_banner" - not necessarily obvious. As
> this is useful information, append to the output of "e" command.
> 
> Example output:
> $mon> e
> cpu 0x1: Vector: 0  at [c0000000f879ba80]
>     pc: c000000000081718: sysrq_handle_xmon+0x68/0x80
>     lr: c000000000081718: sysrq_handle_xmon+0x68/0x80
>     sp: c0000000f879bbe0
>    msr: 8000000000009033
>   current = 0xc0000000f604d5c0
>   paca    = 0xc00000000fdc0480	 softe: 0	 irq_happened: 0x01
>     pid   = 2467, comm = bash
> Linux version 4.4.0-rc2-00008-gc51af91c3ab3-dirty (rashmica@circle) (gcc
> version 5.1.1 20150629 (GCC) ) #45 SMP Wed Nov 25 10:25:12 AEDT 2015
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eb925d64604991095b6e9476

cheers
