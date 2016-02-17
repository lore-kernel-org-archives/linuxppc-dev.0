Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB4FC1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:25 +1100 (AEDT)
In-Reply-To: <20160210032405.GA8979@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [V2,1/1] powerpc/perf/hv-gpci: Increase request buffer size
Message-Id: <20160217124125.A222E140556@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-02 at 03:24:05 UTC, Sukadev Bhattiprolu wrote:
> >From f1afe08fbc9797ff63adf03efe564a807a37cfe6 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 9 Feb 2016 02:47:45 -0500
> Subject: [PATCH V2 1/1] powerpc/perf/hv-gpci: Increase request buffer size
> 
> The GPCI hcall allows for a 4K buffer but we limit the buffer to 1K.
> The problem with a 1K buffer is if a request results in returning
> more values than can be accomodated in the 1K buffer the request will
> fail.
> 
> The buffer we are using is currently allocated on the stack and hence
> limited in size. Instead use a per-CPU 4K buffer like we do with 24x7
> counters (hv-24x7.c).
> 
> While here, rename the macro GPCI_MAX_DATA_BYTES to HGPCI_MAX_DATA_BYTES
> for consistency with 24x7 counters.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4f226b1580b36550727c324b4

cheers
