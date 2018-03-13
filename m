Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400vww5N5KzDqgh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:56:00 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id f5-v6so3650227plj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:56:00 -0700 (PDT)
Date: Tue, 13 Mar 2018 22:55:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/14] powerpc/64: move default SPR recording
Message-ID: <20180313225548.2530296c@roar.ozlabs.ibm.com>
In-Reply-To: <87zi3cf9i6.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-8-npiggin@gmail.com>
 <87zi3cf9i6.fsf@concordia.ellerman.id.au>
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

On Tue, 13 Mar 2018 23:25:05 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Move this into the early setup code, and don't iterate over CPU masks.
> > We don't want to call into sysfs so early from setup, and a future patch
> > won't initialize CPU masks by the time this is called.
> > ---
> >  arch/powerpc/kernel/paca.c     |  3 +++
> >  arch/powerpc/kernel/setup.h    |  9 +++------
> >  arch/powerpc/kernel/setup_64.c |  8 ++++++++
> >  arch/powerpc/kernel/sysfs.c    | 18 +++++++-----------
> >  4 files changed, 21 insertions(+), 17 deletions(-)  
> 
> This patch, and 8, 9, 10, aren't signed-off by you.
> 
> I'll assume you just forgot and add it.

Yes I did.

Thanks,
Nick
