Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wnJZ3ddCzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 20:43:57 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id t12-v6so10851193plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 03:43:57 -0700 (PDT)
Date: Wed, 30 May 2018 20:43:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Segher Boessenkool
 <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 1/4] powerpc/kbuild: set default generic machine type
 for 32-bit compile
Message-ID: <20180530204347.45655a87@roar.ozlabs.ibm.com>
In-Reply-To: <CAK7LNASsx_gDQePtNRdiY8v4RbysQqoKKfr1LW6dsz=7fq-oEQ@mail.gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
 <20180516141458.18996-2-npiggin@gmail.com>
 <CAK7LNASsx_gDQePtNRdiY8v4RbysQqoKKfr1LW6dsz=7fq-oEQ@mail.gmail.com>
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

On Tue, 29 May 2018 22:39:48 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-05-16 23:14 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > Some 64-bit toolchains uses the wrong ISA variant for compiling 32-bit
> > kernels, even with -m32. Debian's powerpc64le is one such case, and
> > that is because it is built with --with-cpu=power8.
> >
> > So when cross compiling a 32-bit kernel with a 64-bit toolchain, set
> > -mcpu=powerpc initially, which is the generic 32-bit powerpc machine
> > type and scheduling model. CPU and platform code can override this
> > with subsequent -mcpu flags if necessary.
> >
> > This is not done for 32-bit toolchains otherwise it would override
> > their defaults, which are presumably set appropriately for the
> > environment (moreso than a 64-bit cross compiler).
> >
> > This fixes a lot of build failures due to incompatible assembly when
> > compiling 32-bit kernel with th Debian powerpc64le 64-bit toolchain.
> >
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---  
> 
> 
> Can you please remove the noise changes?
> 
> 1/4 adds some blank lines, then 2/4 removes them.

Okay sure, I will change that.

Thanks,
Nick
