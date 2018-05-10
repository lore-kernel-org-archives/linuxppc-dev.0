Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hN9V5CWgzF2T7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 16:09:49 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id bi12-v6so669269plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 23:09:49 -0700 (PDT)
Date: Thu, 10 May 2018 16:09:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 3/5] kbuild: call cc-option with the current set of
 KBUILD_CFLAGS
Message-ID: <20180510160937.27997d66@roar.ozlabs.ibm.com>
In-Reply-To: <CAK7LNATnJ_xi7nFLA5-MeP=86bK19Z9-L=muCW8LKoDYBpDHGA@mail.gmail.com>
References: <20180510051659.15356-1-npiggin@gmail.com>
 <20180510051659.15356-4-npiggin@gmail.com>
 <CAK7LNATnJ_xi7nFLA5-MeP=86bK19Z9-L=muCW8LKoDYBpDHGA@mail.gmail.com>
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

On Thu, 10 May 2018 14:29:49 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-05-10 14:16 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > In some cases, the options that gcc will accept depend on options it
> > has already been given. For example -m32 / -m64 and -mbig-endian /
> > -mlittle-endian can have this affect.  
> 
> Is cc-option not working for you?

I thought it wasn't, but now I try again and it does work, sorry for
the noise. The bug must have been something in my previous series.
This series seems to work just as well after I remove this patch.

Thanks,
Nick
