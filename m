Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsZ263YzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:34 +1000 (AEST)
In-Reply-To: <20171211032913.31253-1-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH-next] powerpc: remove retired sbc834x support
Message-Id: <40gMsZ193jz9s27@ozlabs.org>
Date: Wed,  9 May 2018 00:52:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-12-11 at 03:29:13 UTC, Paul Gortmaker wrote:
> I no longer have a functional version of this board for even the most
> basic sanity boot testing, and they have not been available for purchase
> for quite some years now.
> 
> There is no point in adding a burden to testing coverage that does
> walk all the possible defconfigs, so with all the above in mind, it
> makes sense to remove it.  Of course it will remain in the git history
> for anyone who happens to stumble on one and wants to tinker with it.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3bc6cf5a86e5e506250c03dfcdf971

cheers
