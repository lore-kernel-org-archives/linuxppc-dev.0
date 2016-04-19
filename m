Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1Bl6hZTzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:16:31 +1000 (AEST)
In-Reply-To: <1460552003-15409-4-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: pmladek@suse.com, jeyu@redhat.com, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [3/5] powerpc/livepatch: Add livepatch header
Message-Id: <3qq1Bl2PTgz9t8l@ozlabs.org>
Date: Tue, 19 Apr 2016 20:16:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-04 at 12:53:21 UTC, Michael Ellerman wrote:
> Add the powerpc specific livepatch definitions. In particular we provide
> a non-default implementation of klp_get_ftrace_location().
> 
> This is required because the location of the mcount call is not constant
> when using -mprofile-kernel (which we always do for live patching).
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f63e6d89876034c21ecd18bb1c

cheers
