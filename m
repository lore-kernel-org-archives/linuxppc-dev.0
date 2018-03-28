Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xC690GzF2M7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:19 +1100 (AEDT)
In-Reply-To: <20180109055214.32199-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel] powerpc/lpar/debug: Initialize flags before printing
 debug message
Message-Id: <40B8xC2bcZz9s0m@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-09 at 05:52:14 UTC, Alexey Kardashevskiy wrote:
> With enabled DEBUG, there is a compile error:
> "error: ‘flags’ is used uninitialized in this function".
> 
> This moves pr_devel() little further where @flags are initialized.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a8c0bf3c621e0acc01451e27fe47c4

cheers
