Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNLvS6RKbzDrgx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 05:15:16 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id t127so13069425oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 12:15:16 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1472445840.2889.99.camel@kernel.crashing.org>
References: <1472445840.2889.99.camel@kernel.crashing.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Aug 2016 12:15:13 -0700
Message-ID: <CA+55aFwo321H+EYjOuwhfJvrn+vbfoT0fV8TMHSy2C0BYSD+EA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-4 tag
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 28, 2016 at 9:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> This is my first signed-tag and use of 2fa so I hope I got it all right...
> I tried to use the same format Michael uses for the tag etc...

The signature all looks fine, but when the contents of the tag are
just the same git information that you can get from git itself, it's
not useful as a merge message. So I prefer the actual high-level "what
changed" message instead:

> We have some misc fixes for powerpc 4.8. Some trivial bits and some
> regressions, and a trivial cleanup or two that I saw no point in letting
> rot in patchwork.

.. although optimally with a *bit* more detail.

Anyway, pulled.

                 Linus
