Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8YGb66F2zDvQQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:21:11 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id n85so3682925pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 22:21:11 -0700 (PDT)
Date: Thu, 3 Nov 2016 16:21:00 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Shreyas B . Prabhu"
 <shreyas@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
Message-ID: <20161103162100.1b50777e@roar.ozlabs.ibm.com>
In-Reply-To: <20161102084548.GD17909@in.ibm.com>
References: <20161013021714.6624-1-npiggin@gmail.com>
 <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
 <20161102082433.GA17365@in.ibm.com>
 <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
 <20161102084548.GD17909@in.ibm.com>
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

On Wed, 2 Nov 2016 14:15:48 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hi Nick,
> 
> On Wed, Nov 02, 2016 at 07:36:24PM +1100, Nicholas Piggin wrote:
> > 
> > Okay, I'll work with that. What's the best way to make a P8 do
> > winkle sleeps?  
> 
> From the userspace, offlining the CPUs of the core will put them to
> winkle.

Thanks for this. Hum, that r13 manipulation throughout the idle
and exception code is a bit interesting. I'll do the minimal patch
for 4.9, but what's the reason not to just use the winkle state
in the PACA rather than storing it into HSPRG0 bit, can you (or
Shreyas) explain?

Thanks,
Nick
