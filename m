Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq1Bj4rBszDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:16:29 +1000 (AEST)
In-Reply-To: <1460552003-15409-3-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: pmladek@suse.com, jeyu@redhat.com, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com,
 duwe@lst.de, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [2/5] livepatch: Allow architectures to specify an alternate
 ftrace location
Message-Id: <3qq1Bj3wbTz9t8k@ozlabs.org>
Date: Tue, 19 Apr 2016 20:16:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-04 at 12:53:20 UTC, Michael Ellerman wrote:
> When livepatch tries to patch a function it takes the function address
> and asks ftrace to install the livepatch handler at that location.
> ftrace will look for an mcount call site at that exact address.
> 
> On powerpc the mcount location is not the first instruction of the
> function, and in fact it's not at a constant offset from the start of
> the function. To accommodate this add a hook which arch code can
> override to customise the behaviour.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/28e7cbd3e0f5fefec892842d13

cheers
