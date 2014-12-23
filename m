Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914DC1A0C55
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 11:31:31 +1100 (AEDT)
Message-ID: <1419294690.30550.2.camel@ellerman.id.au>
Subject: Re: [PATCH] [TRIVIAL] IBM Akebono: Remove select of IBM_EMAC_RGMII_WOL
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 23 Dec 2014 11:31:30 +1100
In-Reply-To: <2224792.Nmvmc626jj@mexican>
References: <1415008333.20372.26.camel@x220>
 <1419243273.30945.19.camel@x220> <2224792.Nmvmc626jj@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 09:48 +1100, Alistair Popple wrote:
> Hi Paul,
> 
> These days I've been made maintainer of the PPC4XX tree so maybe adding Acked-
> by: Alistair Popple <alistair@popple.id.au> might help?
> 
> Jiri, if you would rather this go via the main PPC tree please let us know and 
> we'll see if Michael Ellerman (added to CC) would be willing to take it (he 
> has taken over most of the day to day maintenance of the PPC tree). Thanks!

It never went to linuxppc as far as I can see, though I am happy to take it.
Although it is a trivial patch I'd still rather you CC'ed us on patches to
arch/powerpc.

cheers
