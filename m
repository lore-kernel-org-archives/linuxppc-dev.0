Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E3AA1A1DDA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:03:30 +1000 (AEST)
In-Reply-To: <1439538087-32137-2-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: [v5,
 01/11] cxl: Convert MMIO read/write macros to inline functions
Message-Id: <20150817080330.214E01402A0@ozlabs.org>
Date: Mon, 17 Aug 2015 18:03:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-14-08 at 07:41:17 UTC, Daniel Axtens wrote:
> We're about to make these more complex, so make them functions
> first.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/588b34be20bc3dd7441c

cheers
