Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BNlx39XFzF3Tg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:06:36 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id g23-v6so3613582plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:06:36 -0700 (PDT)
Date: Fri, 14 Sep 2018 15:06:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
Message-ID: <20180914150629.405c12cc@roar.ozlabs.ibm.com>
In-Reply-To: <20180914040649.1794-6-joel@jms.id.au>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-6-joel@jms.id.au>
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

On Fri, 14 Sep 2018 13:36:49 +0930
Joel Stanley <joel@jms.id.au> wrote:

> This effectively reverts 7563dc645853 ("powerpc: Work around gcc's
> -fno-omit-frame-pointer bug"), a workaround for a bug in GCC 4.1.3 when
> building 2.6.26 kernel.
> 
> The flag is not supported by clang, but reading the history of the
> bug[1] suggests it is no longer required by supported GCC versions, with
> GCC 4.6 now being the minimum.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=11414
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Last time this was proposed there was an issue reported:
> 
>  https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121214.html
> 
> If some machines still have an issue, we could instead wrap this in a
> flag check.

I don't think we can remove it completely because up to at least 4.6
maybe 4.8 has problems.

I have a few patches lying around I started looking at this... I'll
send them.

Thanks,
Nick
