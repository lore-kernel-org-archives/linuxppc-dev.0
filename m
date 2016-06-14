Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTFRR5YGGzDqgV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 13:26:11 +1000 (AEST)
Message-ID: <1465874771.18900.4.camel@ellerman.id.au>
Subject: Re: Rational for having CONFIG_FB_RADEON=m
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 13:26:11 +1000
In-Reply-To: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
References: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
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

On Mon, 2016-06-13 at 17:46 +0200, Mathieu Malaterre wrote:

> 2. Try to fix `radeonfb` so that it is able to kick offb out of the
> way. Eg: https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.html
> 
> From my understanding it would make sense to go for (2), since it
> would allow for proper support for CONFIG_FB_RADEON=m on PowerMac. In
> this case, would such patch be accepted ?

Sounds like the right fix to me. Ben's patch above was merged, so it's supposed
to kick out offb AFAICS, the fact that it can't seems like a bug.

cheers
