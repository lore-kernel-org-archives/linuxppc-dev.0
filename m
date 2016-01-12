Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D95D91A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:46 +1100 (AEDT)
In-Reply-To: <1452491630-22690-2-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 gwshan@linux.vnet.ibm.com
Subject: Re: [2/2] powerpc/powernv: Reserve PE#0 on NPU
Message-Id: <20160112123246.72D3A140779@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-01 at 05:53:50 UTC, Alistair Popple wrote:
> P8+ hardware reports all errors on PE#0. This patch ensures PE#0 is
> not assigned to NPU devices so that it can be used for EEH.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/08f48f3234a79bca86c2283a16

cheers
