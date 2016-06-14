Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTRrx5qSPzDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:15:29 +1000 (AEST)
Message-ID: <1465902911.30200.6.camel@kernel.crashing.org>
Subject: Re: Rational for having CONFIG_FB_RADEON=m
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Mathieu Malaterre
 <malat@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 21:15:11 +1000
In-Reply-To: <1465874771.18900.4.camel@ellerman.id.au>
References: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
 <1465874771.18900.4.camel@ellerman.id.au>
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

On Tue, 2016-06-14 at 13:26 +1000, Michael Ellerman wrote:
> On Mon, 2016-06-13 at 17:46 +0200, Mathieu Malaterre wrote:
> 
> > 2. Try to fix `radeonfb` so that it is able to kick offb out of the
> > way. Eg: https://lists.freedesktop.org/archives/dri-devel/2010-Augu
> > st/002907.html
> > 
> > From my understanding it would make sense to go for (2), since it
> > would allow for proper support for CONFIG_FB_RADEON=m on PowerMac.
> > In
> > this case, would such patch be accepted ?
> 
> Sounds like the right fix to me. Ben's patch above was merged, so
> it's supposed
> to kick out offb AFAICS, the fact that it can't seems like a

Make sure you have CONFIG_VT_HW_CONSOLE_BINDING=y

Ben.

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
