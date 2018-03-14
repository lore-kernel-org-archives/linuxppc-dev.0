Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGB18c0zDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:46 +1100 (AEDT)
In-Reply-To: <20180214211519.15683-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/via-pmu: Fix section mismatch warning
Message-Id: <401RG939z2z9sD0@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-14 at 21:15:18 UTC, Mathieu Malaterre wrote:
> Make the struct via_pmu_driver const to avoid following warning:
> 
> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
> The variable via_pmu_driver references
> the function __init pmu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/58935176ad17976b7a7f6ea25c0ceb

cheers
