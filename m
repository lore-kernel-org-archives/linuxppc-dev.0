Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0nQH4Xx4zDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 21:01:43 +1000 (AEST)
In-Reply-To: <20170629215538.1645-2-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [v3,
 1/8] powerpc/perf/hv-24x7: Fix passing of catalog version number
Message-Id: <3x0nQH2RsPz9sNx@ozlabs.org>
Date: Sun,  2 Jul 2017 21:01:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-29 at 21:55:31 UTC, Thiago Jung Bauermann wrote:
> H_GET_24X7_CATALOG_PAGE needs to be passed the version number obtained from
> the first catalog page obtained previously. This is a 64 bit number, but
> create_events_from_catalog truncates it to 32-bit.
> 
> This worked on POWER8, but POWER9 actually uses the upper bits so the call
> fails with H_P3 because the hypervisor doesn't recognize the version.
> 
> This patch also adds the hcall return code to the error message, which is
> helpful when debugging the problem.
> 
> Fixes: 5c5cd7b50259 ("powerpc/perf/hv-24x7: parse catalog and populate sysfs with events")
> Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/12bf85a71000af7419b19b5e909109

cheers
