Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RG240YhzDqhw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:38 +1100 (AEDT)
In-Reply-To: <1471884782-20403-1-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: wei.guo.simon@gmail.com, cyrilbur@gmail.com
Subject: Re: selftest/powerpc: Add test for sigreturn in transaction
Message-Id: <401RG21ybdz9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:37 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-22 at 16:53:02 UTC, Laurent Dufour wrote:
> Ensure that kernel is throwing away the suspended transaction when
> sigreturn() is called otherwise it if fails to restore the signal
> frame's TM SPRS.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c96c932871efeabe82fcfdc952f35

cheers
