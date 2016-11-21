Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMkRm2fTxzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 20:52:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ibmebus: Remove legacy suspend/resume support
In-Reply-To: <1479562934-1541-1-git-send-email-lars@metafoo.de>
References: <1479562934-1541-1-git-send-email-lars@metafoo.de>
Date: Mon, 21 Nov 2016 20:52:51 +1100
Message-ID: <87polpw45o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lars-Peter Clausen <lars@metafoo.de> writes:

> There are no ibmebus driver that make use of legacy suspend/resume. This
> patch removes the support for it from ibmebus framework, new ibmebus driver
> (as unlikely as they are) wanting to use suspend/resume should use
> dev_pm_ops.
>
> Since there aren't any special bus specific things to do during
> suspend/resume and since the PM core will automatically fallback directly
> to using the device's PM ops if no bus PM ops are specified there is no
> need to have any special ibmebus PM ops at all.

Thanks, this looks like a really nice cleanup.

I don't know the PM code at all, is there any down side to removing all
of this?

cheers
