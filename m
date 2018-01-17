Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Bw2CD5zF0Zv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:26:00 +1100 (AEDT)
In-Reply-To: <20180116112401.942-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: Wire up cpu_show_meltdown()
Message-Id: <3zM7Bv43zdz9sQm@ozlabs.org>
Date: Thu, 18 Jan 2018 00:25:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-16 at 11:24:01 UTC, Michael Ellerman wrote:
> The recent commit 87590ce6e373 ("sysfs/cpu: Add vulnerability folder")
> added a generic folder and set of files for reporting information on
> CPU vulnerabilities. One of those was for meltdown:
> 
>   /sys/devices/system/cpu/vulnerabilities/meltdown
> 
> This commit wires up that file for 64-bit Book3S powerpc.
> 
> For now we default to "Vulnerable" unless the RFI flush is enabled.
> That may not actually be true on all hardware, further patches will
> refine the reporting based on the CPU/platform etc. But for now we
> default to being pessimists.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/fd6e440f20b1a4304553775fc55938

cheers
