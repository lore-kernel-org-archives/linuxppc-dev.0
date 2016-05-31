Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJqD75wS6zDqh1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:17:11 +1000 (AEST)
In-Reply-To: <1460010507-24777-2-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V3,2/2] pseries/eeh: Refactor the configure_bridge RTAS tokens
Message-Id: <3rJqD75PC8z9t41@ozlabs.org>
Date: Tue, 31 May 2016 20:17:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-04 at 06:28:27 UTC, Russell Currey wrote:
> The RTAS calls "ibm,configure-pe" and "ibm,configure-bridge" perform the
> same actions, however the former can skip configuration if unnecessary.
> The existing code treats them as different tokens even though only one
> will ever be called.  Refactor this by making a single token that is
> assigned during init.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bd000b82e86503d5e8b9e6d40a

cheers
