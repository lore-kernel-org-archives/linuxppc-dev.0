Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF541A300F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 15:09:42 +1100 (AEDT)
Message-ID: <1444190982.6794.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2] cxl: Fix number of allocated pages in SPA
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 07 Oct 2015 15:09:42 +1100
In-Reply-To: <1444189526-sup-3467@delenn.ozlabs.ibm.com>
References: <1444141189-16621-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1444189526-sup-3467@delenn.ozlabs.ibm.com>
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

On Wed, 2015-10-07 at 14:51 +1100, Ian Munsie wrote:
> The explanation probably still needs to be expanded more (e.g. this
> could cause a crash for an AFU that supports more than about a thousand
> processes) - see my other email in reply to v1 for more, but I'm happy
> for this to go in as is (but ultimately that's mpe's call).
> 
> It should also be CCd to stable, this bug was introduced before the
> driver was originally upstreamed, we just never hit it because all our
> AFUs are limited to less processes by their interrupt requirements.
> 
> Cc: stable <stable@vger.kernel.org>

So the driver went into 3.18, so this should be:

Cc: stable <stable@vger.kernel.org> # 3.18+

One of you please resend with a coherent change log with all the details
included.

cheers
