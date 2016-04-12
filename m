Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkTJJ4mgZzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 11:05:36 +1000 (AEST)
Message-ID: <1460423136.24701.30.camel@neuling.org>
Subject: Re: [RFC] P9 ldmx support
From: Michael Neuling <mikey@neuling.org>
To: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Apr 2016 11:05:36 +1000
In-Reply-To: <1460401065-10540-1-git-send-email-jack@codezen.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
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


> Re: [RFC] P9 ldmx support

These are good to go and don't need to be marked as RFC.

FWIW, we've been testing these internally and they've been solid.

> These are patches based on next to support the forthcoming ldmx
> instruction through the existing P8 EBB infrastructure. Obviously it
> doesn't actually *work* without some other patches and a P9 system,
> but with the context switch change to FSCR it makes sense to get
> this upstream for testing ASAP.

Yep.

Thanks,
Mikey

> The first patch context switches FSCR per thread so that the second patch=
 can
> lazily enable this feature (FSCR.LM) with a facility unavailable exceptio=
n
> and context switch two new ldmx registers (LMRR / LMSER) per thread as we=
ll.
> Third patch is a couple of basic tests.
