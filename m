Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHQ6vJlzDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:50 +1100 (AEDT)
In-Reply-To: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] xmon: Setup xmon debugger hooks when first break-point is set
Message-Id: <401RHQ2TS9z9s2R@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-03-04 at 17:30:25 UTC, Vaibhav Jain wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line. However this
> doesn't enable the kernel debugger hooks needed for instruction or data
> breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
> of the form below is reported:
> 
> Oops: Exception in kernel mode, sig: 5 [#1]
> < snip >
> Trace/breakpoint trap
> 
> To fix this the patch checks and enables debugger hooks when an
> instruction or data break-point is set via xmon console.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1368d0c9edbc366e45216e7295fd6

cheers
