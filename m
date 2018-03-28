Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xP30BLzF2ML
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:29 +1100 (AEDT)
In-Reply-To: <1521632426-30770-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/perf: Fix kernel address leak to userspace via BHRB
 buffer
Message-Id: <40B8xM6NJKz9s0m@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-21 at 11:40:25 UTC, Madhavan Srinivasan wrote:
> The current Branch History Rolling Buffer (BHRB) code does
> not check for any privilege levels before updating the data
> from BHRB. This leaks kernel addresses to userspace even when
> profiling only with userspace privileges. Add proper checks
> to prevent it.
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bb19af816025d495376bd76bf6fbcf

cheers
