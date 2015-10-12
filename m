Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDA8C1A06B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 13:53:55 +1100 (AEDT)
Message-ID: <1444618435.7194.2.camel@ellerman.id.au>
Subject: Re: use interrupt without clearing ?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 12 Oct 2015 13:53:55 +1100
In-Reply-To: <CAJ2oMhLMi2PZvQoFU7JuYSsJM_UbuTsOaRfQKxqsJQq=KDG9vQ@mail.gmail.com>
References: <CAJ2oMhLMi2PZvQoFU7JuYSsJM_UbuTsOaRfQKxqsJQq=KDG9vQ@mail.gmail.com>
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

On Sun, 2015-10-11 at 15:13 +0300, Ran Shalit wrote:
> Hello,
> 
> Is it possible to register an interrupt (in linux), without using the
> automatic clear of interrupt.
> I need this just for testing.

Hi Ran,

You need to give us much more info than that before anyone will be able to
answer your question. Linux runs on lots of different powerpc machines, so
without knowing what hardware you're talking about it's impossible to
answer.

cheers
