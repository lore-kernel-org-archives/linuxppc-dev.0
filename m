Return-Path: <joel.stan@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D9HC64B1zDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 12:36:23 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id r37-v6so14051094qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 19:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180914050854.6214-1-npiggin@gmail.com>
 <20180914050854.6214-4-npiggin@gmail.com>
In-Reply-To: <20180914050854.6214-4-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Sep 2018 12:06:10 +0930
Message-ID: <CACPK8Xe1rrOaRUJSOSg7rocofA1_ePFd5Gp-1V5+xVKge3GbhQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2018 at 14:39, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I gave this a spin with clang trunk on the powernv kernel and it did
the trick. Thanks!

mpe, this series supersedes [v2,5/5] powerpc: Remove -mno-sched-epilog
(https://patchwork.ozlabs.org/patch/969615/).

Cheers,

Joel
