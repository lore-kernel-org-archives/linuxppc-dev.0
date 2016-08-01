Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2qfR2hZjzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 16:48:15 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id q2so9369183pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 23:48:15 -0700 (PDT)
Date: Mon, 1 Aug 2016 16:48:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 09/11] powerpc: Add support to mask perf interrupts
Message-ID: <20160801164806.2a24e1b5@roar.ozlabs.ibm.com>
In-Reply-To: <7f7cf8cd-55cd-18ba-b071-95ec44ac18aa@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-10-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801152941.6a225a01@roar.ozlabs.ibm.com>
 <7f7cf8cd-55cd-18ba-b071-95ec44ac18aa@linux.vnet.ibm.com>
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

On Mon, 1 Aug 2016 11:39:18 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Monday 01 August 2016 10:59 AM, Nicholas Piggin wrote:
> > On Mon,  1 Aug 2016 00:36:27 +0530
> > Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> > And that would disable both handlers that test with IRQ_DISABLE_LEVEL_LINUX
> > and IRQ_DISABLE_LEVEL_PMU
> >
> > Does that make sense? What do you think?  
> 
> Yes. it make sense.
> But would like to get comments for the SOFTEN_TEST changes.

Well I think they look good. We'll give others a chance to read and
comment. I'm sure Ben will want to check it out but he's pretty busy...

Thanks,
Nick
