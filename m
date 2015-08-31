Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A95F1A0170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 11:46:35 +1000 (AEST)
Message-ID: <1440985594.5735.3.camel@ellerman.id.au>
Subject: Re: talitos doesn't build with GCC 4.4.4 (was Re: [PATCH v3 07/17]
 crypto: talitos - enhanced talitos_desc struct for SEC1)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 31 Aug 2015 11:46:34 +1000
In-Reply-To: <55E33C50.2000505@c-s.fr>
References: <20150417143201.7C8B41A242C@localhost.localdomain>
 <1440930307.907.5.camel@ellerman.id.au> <55E33C50.2000505@c-s.fr>
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

On Sun, 2015-08-30 at 19:24 +0200, christophe leroy wrote:
> Hi Michael,
> 
> This should be fixed by that one:
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=76bea64c4c8d7fa911eb485c4c2b8583e813331e

Thanks.

Sorry I should have thought to check linux-next.

cheers
