Return-Path: <luc.vanoostenryck@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428BSQ1G7rzF396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 01:15:33 +1000 (AEST)
Received: by mail-wm0-x22f.google.com with SMTP id q8-v6so21918509wmq.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 08:15:33 -0700 (PDT)
Date: Mon, 10 Sep 2018 17:15:27 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
 Kees Cook <keescook@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org,
 sparse@chrisli.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910151526.ljp3nynngprdmlkb@ltop.local>
References: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
 <20180910135604.j2phe7r3k5vs6cik@ltop.local>
 <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2018 at 04:05:34PM +0200, Christophe LEROY wrote:
> 
> This time it works, thanks for your help.

You're welcome.
 
> Should we find a may to automate that in the Makefile when
> CROSS_COMPILE is defined ?

The situation here with an old gcc is really an oddity.
I was instead thinking to update sparse so that it repports a
GCC version of at least 4.6, maybe something even more recent.

But maybe, yes, kbuild could pass GCC_VERSION to sparse so
that both the compiler used and sparse will repport the same.
I'll see. The problem is not tied to cross-compilation, though,
just that sparse may be compiled with an older compiler.

-- Luc
