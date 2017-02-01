Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL66BmZzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:34 +1100 (AEDT)
In-Reply-To: <1476384330-22654-1-git-send-email-arbab@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm: simplify loop control in parse_numa_properties()
Message-Id: <3vClL51GC1z9tjx@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-10-13 at 18:45:30 UTC, Reza Arbab wrote:
> The flow of the main loop in parse_numa_properties() is overly
> complicated. Simplify it to be less confusing and easier to read.
> No functional change.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7656cd8e8e23ac4b059f4d96939cb7

cheers
