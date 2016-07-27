Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzyBl4cHnzDrWy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:32:47 +1000 (AEST)
In-Reply-To: <20160711033858.16172-2-sam@mendozajonas.com>
To: Sam Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, "# 4 . 1 . x-" <stable@vger.kernel.org>,
 Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>
Subject: Re: [V2,2/2] tty/hvc: Use opal irqchip interface if available
Message-Id: <3rzyBl2QmKz9t2L@ozlabs.org>
Date: Thu, 28 Jul 2016 00:32:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-07 at 03:38:58 UTC, Sam Mendoza-Jonas wrote:
> Update the hvc driver to use the OPAL irqchip if made available by the
> running firmware. If it is not present, the driver falls back to the
> existing OPAL event number.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/00dab8187e182da41122f66c20

cheers
