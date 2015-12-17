Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 671AD1A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:35 +1100 (AEDT)
In-Reply-To: <1449445851-6822-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [v2] selftests/powerpc: Add script to test HMI functionality
Message-Id: <20151217115735.46CE71401DA@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-06-12 at 23:50:51 UTC, Daniel Axtens wrote:
> HMIs (Hypervisor Management|Maintenance Interrupts) are a class of interrupt
> on POWER systems.
> 
> HMI support has traditionally been exceptionally difficult to test, however
> Skiboot ships a tool that, with the correct magic numbers, will inject them.
> 
> This, therefore, is a first pass at a script to inject HMIs and monitor
> Linux's response. It injects an HMI on each core on every chip in turn
> It then watches dmesg to see if it's acknowledged by Linux.
> 
> On a Tuletta, I observed that we see 8 (or sometimes 9 or more) events per
> injection, regardless of SMT setting, so we wait for 8 before progressing.
> 
> It sits in a new scripts/ directory in selftests/powerpc, because it's not
> designed to be run as part of the regular make selftests process. In
> particular, it is quite possibly going to end up garding lots of your CPUs,
> so it should only be run if you know how to undo that.
> 
> CC: Mahesh J Salgaonkar <mahesh.salgaonkar@in.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a8da474ec18f4c4c39f83202d6

cheers
