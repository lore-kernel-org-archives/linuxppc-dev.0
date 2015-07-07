Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0C101A1059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:04 +1000 (AEST)
In-Reply-To: <1435909152-18891-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: opal-elog: Fix opal-elog interrupt handler
Message-Id: <20150707103804.0AF2B1402C2@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-07 at 07:39:12 UTC, Alistair Popple wrote:
> The conversion of opal events to a proper irqchip means that handlers
> are called until the relevant opal event has been cleared by
> processing it. Events that queue work should therefore use a threaded
> handler to mask the event until processing is complete.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=a8956a7b7232da5f4ce4a305c72a54cc5e4a8307

cheers
