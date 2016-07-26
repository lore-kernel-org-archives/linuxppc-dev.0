Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7gt3DFpzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:36:42 +1000 (AEST)
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rz7gs6DC0z9t15
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2016 16:36:41 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so12779516pac.1
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jul 2016 23:36:41 -0700 (PDT)
Date: Tue, 26 Jul 2016 16:36:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/64: Do load of PACAKBASE in LOAD_HANDLER
Message-ID: <20160726163627.148bbf6a@roar.ozlabs.ibm.com>
In-Reply-To: <1469510970-11599-2-git-send-email-mpe@ellerman.id.au>
References: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
 <1469510970-11599-2-git-send-email-mpe@ellerman.id.au>
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

On Tue, 26 Jul 2016 15:29:30 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> The LOAD_HANDLER macro requires that you have previously loaded "reg"
> with PACAKBASE. Although that gives callers flexibility to get
> PACAKBASE in some interesting way, none of the callers actually do
> that. So fold the load of PACAKBASE into the macro, making it simpler
> for callers to use correctly.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I don't see any problem with this.

Reviewed-by: Nick Piggin <npiggin@gmail.com>
