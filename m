Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQrqd12QNzDrpK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 06:50:37 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id e126so2504572oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 13:50:37 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.10.1609022241560.3378@hadrien>
References: <CAKMK7uEuqLLf2bCyB-sAuu5WvVA1Kp7Jvc33k3um5DfdQr4eyg@mail.gmail.com>
 <20160902104619.GD9355@localhost>
 <CA+55aFwSpNrOuOzaR5hh0A1XvuTu0=xVbE_CV1RVf9GMrTPDNQ@mail.gmail.com>
 <7359509.5sppVSLXcK@wuerfel>
 <CA+55aFzw-KkQOhVJG+c-WEFA=6o5aXy=yU9KXQ7jwy-xy--d9Q@mail.gmail.com>
 <alpine.DEB.2.10.1609022241560.3378@hadrien>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Sep 2016 13:50:34 -0700
Message-ID: <CA+55aFx+bk4p80UYzXw+a7avwJ37eVz6PXMhK9PPt5hdnGxxVQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [CORE TOPIC] (group) maintainership models
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 ksummit-discuss@lists.linuxfoundation.org,
 "Nikula, Jani" <jani.nikula@linux.intel.com>, Dave Airlie <airlied@linux.ie>,
 Grant Likely <grant.likely@linaro.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 2, 2016 at 1:43 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Like this?

Sure.

> Is it always correct to replace return NO_IRQ by return 0?

On platforms that define it to 0, like powerpc, yes.

On arm, c6x, mn10300, parisc and sparc it would need more work.

> Completely untested patch below.

Looks fine, but the ppc people should test it (although it really
should generate the exact same code, unless there was some odd
conversion case).

                 Linus
