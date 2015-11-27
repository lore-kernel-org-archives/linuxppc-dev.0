Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2D3B1A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2015 01:30:09 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Thomas Huth <thuth@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmicy@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ben@codiert.org
Subject: Re: [PATCH] powerpc/cell: Remove the Cell QPACE code.
Date: Fri, 27 Nov 2015 15:29:51 +0100
Message-ID: <8176551.IckxS0ByhD@wuerfel>
In-Reply-To: <5656FD6D.2020607@redhat.com>
References: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
 <1448539743.22295.14.camel@ellerman.id.au> <5656FD6D.2020607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 26 November 2015 13:39:09 Thomas Huth wrote:
> On 26/11/15 13:09, Michael Ellerman wrote:
> > On Thu, 2015-11-26 at 11:47 +0100, Thomas Huth wrote:
> > 
> >> On 26/11/15 01:59, Rashmica Gupta wrote:
> > 
> >>> All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> >>>
> >>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> >>> ---
> >>>  arch/powerpc/boot/Makefile                |   2 -
> >>>  arch/powerpc/configs/ppc64_defconfig      |   1 -
> >>>  arch/powerpc/platforms/cell/Kconfig       |   5 -
> >>>  arch/powerpc/platforms/cell/Makefile      |   3 -
> >>>  arch/powerpc/platforms/cell/qpace_setup.c | 148 ------------------------------
> >>>  5 files changed, 159 deletions(-)
> >>>  delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c
> >>
> >> There one more reference to qpace in the file
> >>  Documentation/devicetree/bindings/serial/8250.txt
> >> ... you might want to remove that, too.
> > 
> > There's also one in drivers/tty/serial/of_serial.c.
> > 
> > Arnd said he already had a patch to remove those, not sure if he's sent it
> > though.
> 
> He apparently did:
> 
>  https://lkml.org/lkml/2015/11/16/454
> 
> So the change to the file in Documentation should ideally go also into
> his patch instead, I think.

I think Greg is currently backlogged on all patches sent to him, but they
should show up in linux-next once he's caught up after Thanksgiving.

	Arnd
