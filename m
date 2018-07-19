Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNpf1NqCzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:38 +1000 (AEST)
In-Reply-To: <153016319642.8584.7868984232962915832.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, dgibson@redhat.com
Subject: Re: powerpc/kdump: handle crashkernel memory reservation failure
Message-Id: <41WNpc5Jvtz9s5K@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-28 at 05:19:56 UTC, Hari Bathini wrote:
> Memory reservation for crashkernel could fail if there are holes around
> kdump kernel offset (128M). Fail gracefully in such cases and print an
> error message.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: David Gibson <dgibson@redhat.com>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8950329c4a64c6d3ca0bc34711a1af

cheers
