Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FC631A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:44 +1100 (AEDT)
In-Reply-To: <1452491630-22690-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 gwshan@linux.vnet.ibm.com
Subject: Re: [1/2] powerpc/powernv: Change NPU PE# assignment
Message-Id: <20160112123244.3613B1401E7@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-01 at 05:53:49 UTC, Alistair Popple wrote:
> The P8+ hardware supports four partitionable endpoints (PEs) however
> the hardware reports all errors as occurring on PE#0. This means we
> need to reserve this PE for error handling (EEH) and not assign it to
> a NPU device, implying that some devices will need to share PEs.
> 
> This patch changes the PE assignment for NPU devices such that NPU
> devices which connect to the same GPU are assigned to the same
> PE#.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b521549a09ddfac3bed38e2611

cheers
