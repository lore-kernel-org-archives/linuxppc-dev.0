Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zllpL39ctzDqff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:04:42 +1100 (AEDT)
Message-ID: <1519095881.7360.59.camel@neuling.org>
Subject: Re: [RFC PATCH 12/12] [WIP] selftests/powerpc: Remove incorrect
 tm-syscall selftest
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 14:04:41 +1100
In-Reply-To: <20180220002241.29648-13-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-13-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> --- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
> +++ /dev/null
> @@ -1,106 +0,0 @@
> -/*
> - * Copyright 2015, Sam Bobroff, IBM Corp.
> - * Licensed under GPLv2.
> - *
> - * Test the kernel's system call code to ensure that a system call
> - * made from within an active HTM transaction is aborted with the
> - * correct failure code.

The above is still true

> - * Conversely, ensure that a system call made from within a
> - * suspended transaction can succeed.

This is true anymore....

So can we just modify the test to remove the second part?

Mikey
