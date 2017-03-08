Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6p094jzDqYl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:54 +1100 (AEDT)
In-Reply-To: <20170227033241.GA3591@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64: Invalidate process table caching after setting
 process table
Message-Id: <3vdQ6n5bMfz9sNG@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-27 at 03:32:41 UTC, Paul Mackerras wrote:
> The POWER9 MMU reads and caches entries from the process table.
> When we kexec from one kernel to another, the second kernel sets
> its process table pointer but doesn't currently do anything to
> make the CPU invalidate any cached entries from the old process table.
> This adds a tlbie (TLB invalidate entry) instruction with parameters
> to invalidate caching of the process table after the new process
> table is installed.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7a70d7288c926ae88e0c773fbb506a

cheers
