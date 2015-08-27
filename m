Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42481A0541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 13:16:44 +1000 (AEST)
Message-ID: <1440645404.23182.12.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Update defconfigs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Date: Thu, 27 Aug 2015 13:16:44 +1000
In-Reply-To: <1440598867.16577.112.camel@freescale.com>
References: <1440589636-14616-1-git-send-email-mpe@ellerman.id.au>
 <1440598867.16577.112.camel@freescale.com>
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

On Wed, 2015-08-26 at 09:21 -0500, Scott Wood wrote:
> On Wed, 2015-08-26 at 21:47 +1000, Michael Ellerman wrote:
> > Mostly uninteresting, though a few worth noting:
...
> >  91 files changed, 19 insertions(+), 128 deletions(-)
> 
> This conflicts with the 85xx config fragment patches that I've already sent 
> you a pull request for...

Duh yep. I'll fix it up.

cheers
