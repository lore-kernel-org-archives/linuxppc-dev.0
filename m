Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D80E41A1197
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 05:26:57 +1000 (AEST)
Received: by ykdt18 with SMTP id t18so89777079ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 12:26:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443692770-44944-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443692770-44944-1-git-send-email-andriy.shevchenko@linux.intel.com>
Date: Thu, 1 Oct 2015 22:26:53 +0300
Message-ID: <CAOJe8K3YLntJ1OfHijfQrXisrJ2yUmmuaTzEo2MG18MhUH1cAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] powerpc/pseries: bug fix and clean up
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/1/15, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Changelog v2:
>  - fix compiler error
>  - rebase on top of recent linux-next
>  - compile tested
>
> Andy Shevchenko (5):
>   powerpc/pseries: extract of_helpers module
>   powerpc/pseries: fix a potential memory leak
>   powerpc/pseries: replace kmalloc + strlcpy
>   powerpc/pseries: handle nodes without '/'
>   powerpc/pseries: re-use code from of_helpers module

Ok, looks like it's working for me.

Tested-by: Denis Kirjanov <kda@linux-powerpc.org>


>
>  arch/powerpc/platforms/pseries/Makefile     |  1 +
>  arch/powerpc/platforms/pseries/dlpar.c      | 31 +++++--------------------
>  arch/powerpc/platforms/pseries/of_helpers.c | 35
> +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/of_helpers.h |  8 +++++++
>  arch/powerpc/platforms/pseries/reconfig.c   | 34
> ++--------------------------
>  5 files changed, 51 insertions(+), 58 deletions(-)
>  create mode 100644 arch/powerpc/platforms/pseries/of_helpers.c
>  create mode 100644 arch/powerpc/platforms/pseries/of_helpers.h
>
> --
> 2.5.1
>
>
