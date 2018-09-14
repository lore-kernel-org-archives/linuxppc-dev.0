Return-Path: <ndesaulniers@google.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bk0m1N8nzF3XJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 04:03:51 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id p12-v6so4659063pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-6-joel@jms.id.au>
 <20180914150629.405c12cc@roar.ozlabs.ibm.com>
In-Reply-To: <20180914150629.405c12cc@roar.ozlabs.ibm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 11:03:38 -0700
Message-ID: <CAKwvOdn-e60VSvUzmSLGx6yx-wUzSaEtdA3q5xyZ+G_++nQSJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
To: Nicholas Piggin <npiggin@gmail.com>
Cc: joel@jms.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> Last time this was proposed there was an issue reported:
>
>  https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121214.html

Heh, did PASemi sell boxes? Interesting, I'll have to read up on my history.

On Thu, Sep 13, 2018 at 10:06 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> I don't think we can remove it completely because up to at least 4.6
> maybe 4.8 has problems.
>
> I have a few patches lying around I started looking at this... I'll
> send them.

Yeah, it's too bad the link above doesn't mention gcc version.

The gcc bugreport mentions fixing the bug in
7563dc64585324f443f5ac107eb6d89ee813a2d2, not sure how to check what
release version of gcc that is? (Do they tag releases?)

Nick, do you have a test case or more context about this still being
an issue in gcc 4.8? (maybe I should wait for your patch series?)

-- 
Thanks,
~Nick Desaulniers
