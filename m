Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqm1f48zF1mw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:56 +1000 (AEST)
In-Reply-To: <20180523180054.9937-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/xmon: Also setup debugger hooks when single-stepping
Message-Id: <40skql47Ddz9s28@ozlabs.org>
Date: Fri, 25 May 2018 21:41:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 18:00:54 UTC, Michal Suchanek wrote:
> When single-stepping kernel code from xmon without a debug hook enabled
> the kernel crashes. This can happen when kernel starts with xmon on
> crash disabled but xmon is entered using sysrq.
> 
> Call force_enable_xmon when single-stepping in xmon to install the xmon
> debug hooks.
> 
> Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> break-point is set")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7daf59300999693b85233762b847f1

cheers
