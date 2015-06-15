Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8C1A1A0554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 16:41:48 +1000 (AEST)
In-Reply-To: <20150614074607.524658883@telegraphics.com.au>
To: Finn Thain <fthain@telegraphics.com.au>, <linux-kernel@vger.kernel.org>,
 <linux-m68k@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC,v2,01/24] macintosh/nvram: Remove as unused
Message-Id: <20150615064148.83D59140291@ozlabs.org>
Date: Mon, 15 Jun 2015 16:41:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-14-06 at 07:46:08 UTC, Finn Thain wrote:
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/macintosh/nvram.c |  130 ----------------------------------------------
>  1 file changed, 130 deletions(-)

This seems uncontroversial, so I'll take it via powerpc for 4.1.

In future please include the details on how/why it's unused in the changelog.

Geert did the digging for you:

  Removal seems to be forgotten by full-history-linux
  commit 17c6f4635bea74e110ab3558d408c9cd218c568a
  Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
  Date:   Fri Feb 6 14:20:56 2004 +1100
  
      ppc32: Rework nvram management
  
      move drivers/macintosh/nvram.c to drivers/char/generic_nvram.c,
      update platform hooks,
      fix powermac nvram driver for newer machines


I'll fold that into the changelog.

cheers
