Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 507461A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:09:10 +1100 (AEDT)
Message-ID: <1448539743.22295.14.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Remove the Cell QPACE code.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: ben@codiert.org, Arnd Bergmann <arnd@arnddb.de>
Date: Thu, 26 Nov 2015 23:09:03 +1100
In-Reply-To: <5656E334.1060506@redhat.com>
References: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
 <5656E334.1060506@redhat.com>
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

On Thu, 2015-11-26 at 11:47 +0100, Thomas Huth wrote:

> On 26/11/15 01:59, Rashmica Gupta wrote:

> > All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> > 
> > Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> > ---
> >  arch/powerpc/boot/Makefile                |   2 -
> >  arch/powerpc/configs/ppc64_defconfig      |   1 -
> >  arch/powerpc/platforms/cell/Kconfig       |   5 -
> >  arch/powerpc/platforms/cell/Makefile      |   3 -
> >  arch/powerpc/platforms/cell/qpace_setup.c | 148 ------------------------------
> >  5 files changed, 159 deletions(-)
> >  delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c
> 
> There one more reference to qpace in the file
>  Documentation/devicetree/bindings/serial/8250.txt
> ... you might want to remove that, too.

There's also one in drivers/tty/serial/of_serial.c.

Arnd said he already had a patch to remove those, not sure if he's sent it
though.

cheers
