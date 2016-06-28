Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf2DT57bBzDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:32:09 +1000 (AEST)
Message-ID: <1467106510.20278.119.camel@kernel.crashing.org>
Subject: Re: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Binderman <linuxdev.baldrick@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Date: Tue, 28 Jun 2016 19:35:10 +1000
In-Reply-To: <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
References: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
 <1467086888.32607.9.camel@ellerman.id.au>
 <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
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

On Tue, 2016-06-28 at 08:06 +0100, David Binderman wrote:
> 
> I don't know the code, but given that insn is unsigned long and so
> can go
> past 32 bits, using a cast to unsigned int might throw away the
> possibly important
> upper bits.

our instructions are only ever 32-bits. That xmon code is ancient and
originated from 32-bits stuff. In fact some of Paulus earliest xmons
might even have run on platforms where int is 16 bits :-)

Cheers,
Ben.
