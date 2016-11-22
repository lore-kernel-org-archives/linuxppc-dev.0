Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN65y6bYczDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:38:46 +1100 (AEDT)
In-Reply-To: <20161104062040.25903-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/oops: fix pr_cont() issues in instruction dump
Message-Id: <3tN65y5PQmz9sdn@ozlabs.org>
Date: Tue, 22 Nov 2016 11:38:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-04 at 06:20:40 UTC, Andrew Donnellan wrote:
> Since the KERN_CONT changes, the current code in show_instructions() prints
> out a whole bunch of unnecessary newlines. Change occurrences of
> printk("\n") to pr_cont("\n"). While we're here, change all the other
> cases of printk(KERN_CONT ...) to pr_cont() as well.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2ffd04dee0dacff36c03a02434965a

cheers
