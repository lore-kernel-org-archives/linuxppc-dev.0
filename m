Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A71F01A04F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 09:43:49 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 17:43:46 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 49788C90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 17:31:53 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB2Mhha723527606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 22:43:43 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB2Mhh66001487
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 17:43:43 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: Append linux_banner to exception information
 in xmon.
In-Reply-To: <1448419585-5181-1-git-send-email-rashmicy@gmail.com>
References: <1448419585-5181-1-git-send-email-rashmicy@gmail.com>
Date: Thu, 03 Dec 2015 09:43:33 +1100
Message-ID: <87bna8ii96.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rashmica Gupta <rashmicy@gmail.com> writes:
> Currently if you are in xmon without an oops etc. to view the kernel
> version you have to type "d $linux_banner" - not necessarily obvious. As
> this is useful information, append to the output of "e" command.
>
> Example output:
> $mon> e
> cpu 0x1: Vector: 0  at [c0000000f879ba80]
>     pc: c000000000081718: sysrq_handle_xmon+0x68/0x80
>     lr: c000000000081718: sysrq_handle_xmon+0x68/0x80
>     sp: c0000000f879bbe0
>    msr: 8000000000009033
>   current = 0xc0000000f604d5c0
>   paca    = 0xc00000000fdc0480	 softe: 0	 irq_happened: 0x01
>     pid   = 2467, comm = bash
> Linux version 4.4.0-rc2-00008-gc51af91c3ab3-dirty (rashmica@circle) (gcc
> version 5.1.1 20150629 (GCC) ) #45 SMP Wed Nov 25 10:25:12 AEDT 2015
>
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

+10,245,789

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

If I had a dollar for every time this would have helped *this morning*,
I'd at least be buying you enough coffee for it to be problematic.

I'd be keen in it heading to stable@ fixing the actual problem of
"people can't actually include the damn kernel version in their bug
report" - but maybe somebody else can work out if this is something
that's likely to be accepted.
