Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x4Q3l73H4zDr9C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 18:43:15 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so6678216pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Jul 2017 01:43:15 -0700 (PDT)
Date: Sat, 8 Jul 2017 18:42:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] powernv:idle: Move device-tree parsing to one place.
Message-ID: <20170708184253.3f5f6f87@roar.ozlabs.ibm.com>
In-Reply-To: <20170707112539.GA8913@in.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-2-git-send-email-ego@linux.vnet.ibm.com>
 <20170707005340.003c530b@roar.ozlabs.ibm.com>
 <20170707112539.GA8913@in.ibm.com>
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

On Fri, 7 Jul 2017 16:55:39 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Fri, Jul 07, 2017 at 12:53:40AM +1000, Nicholas Piggin wrote:

> > I wouldn't have the wrapper function... but it's your code so it's
> > up to you. One thing though is that this function you have called get_
> > just to return the pointer, but it does not take a reference or
> > allocate memory or initialize the structure. Other functions with the
> > same prefix do such things. Can we make something more consistent?  
> 
> I agree with the wrapper function. But then the alternative was to
> declare this variable as an extern so that cpuidle can access it. Is
> that preferable ?

Yeah I think that's fine.

[snip

> > [snip]
> > 
> > There's a lot of code movement, I haven't reviewed it all carefully, but
> > it looks good in general. I'll apply the patches and check the result
> > in the next few days when I get a bit of time.  
> 
> If it helps, I will post the subsequent version breaking this patch
> into smaller ones.

If you could without too much trouble, that would be a good help.

Thanks,
Nick
