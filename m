Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6jd6JrgzDqQM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:53:09 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so12633568pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:53:09 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:53:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 9/9] powerpc: rewrite local_t using soft_irq
Message-ID: <20160726155301.568771d8@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-10-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-10-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jul 2016 20:22:22 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> https://lkml.org/lkml/2008/12/16/450
> 
> Modifications to Rusty's benchmark code:
>  - Executed only local_t test
> 
> Here are the values with the patch.
> 
> Time in ns per iteration
> 
> Local_t		Without Patch		With Patch
> 
> _inc			28		8
> _add			28		8
> _read			3		3
> _add_return		28		7
> 
> Tested the patch in a
>  - pSeries LPAR (with perf record)

Very nice. I'd like to see these patches get in. We can
probably use the feature in other places too.

Thanks,
Nick
