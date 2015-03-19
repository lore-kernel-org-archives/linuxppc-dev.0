Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 739181A0299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 13:46:41 +1100 (AEDT)
Message-ID: <1426733175.4770.109.camel@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Thu, 19 Mar 2015 13:46:15 +1100
In-Reply-To: <20150318.222517.1444725543017433108.davem@davemloft.net>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sowmini.varadhan@oracle.com, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-18 at 22:25 -0400, David Miller wrote:
> PowerPC folks, we're trying to kill the locking contention in our
> IOMMU allocators and noticed that you guys have a nice solution to
> this in your IOMMU code.
> 
> Sowmini put together a patch series that tries to extract out the
> generic parts of your code and place it in lib/iommu-common.c so
> that both Sparc and PowerPC can make use of it.
> 
> The real test is if powerpc can be converted to use it.
> 
> So if you guys could please take a look at the current version of
> this series at:
> 
> http://patchwork.ozlabs.org/patch/449712/
> http://patchwork.ozlabs.org/patch/449713/
> http://patchwork.ozlabs.org/patch/449715/
> 
> and give us some feedback that would be great.
> 
> After we sort out making this work properly for both architectures we
> can figure out who merges which parts via what tree(s).

Sounds like a good idea ! CC'ing Anton who wrote the pool stuff. I'll
try to find somebody to work on that here & will let you know asap.

Cheers,
Ben.
