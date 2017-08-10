Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSqcJ17dxzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 00:03:43 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id t83so769267pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 07:03:43 -0700 (PDT)
Date: Fri, 11 Aug 2017 00:03:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/13] powerpc/64s: idle POWER9 can execute stop without
 ptesync
Message-ID: <20170811000331.23bd7557@roar.ozlabs.ibm.com>
In-Reply-To: <87wp6blg1l.fsf@concordia.ellerman.id.au>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-12-npiggin@gmail.com>
 <87wp6blg1l.fsf@concordia.ellerman.id.au>
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

On Thu, 10 Aug 2017 23:15:50 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/idle_book3s.S       |  7 ++++---
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 24 ++++++++++++------------  
> 
> If you can split this into a KVM and non-KVM patch that would be
> helpful.

Yes I can do that.
