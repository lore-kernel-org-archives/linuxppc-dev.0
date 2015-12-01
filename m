Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18ECA1A0CAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:35:35 +1100 (AEDT)
Message-ID: <1448940934.9027.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Remove the Cell QPACE code.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: ben@codiert.org, Arnd Bergmann <arnd@arndb.de>
Date: Tue, 01 Dec 2015 14:35:34 +1100
In-Reply-To: <5656FD6D.2020607@redhat.com>
References: <1448499587-25604-1-git-send-email-rashmicy@gmail.com>
 <5656E334.1060506@redhat.com> <1448539743.22295.14.camel@ellerman.id.au>
 <5656FD6D.2020607@redhat.com>
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

On Thu, 2015-11-26 at 13:39 +0100, Thomas Huth wrote:
> On 26/11/15 13:09, Michael Ellerman wrote:
> > On Thu, 2015-11-26 at 11:47 +0100, Thomas Huth wrote:
> > > On 26/11/15 01:59, Rashmica Gupta wrote:
> > > > All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> > > > 
> > > > Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> > > > ---
> > > >  arch/powerpc/boot/Makefile                |   2 -
> > > >  arch/powerpc/configs/ppc64_defconfig      |   1 -
> > > >  arch/powerpc/platforms/cell/Kconfig       |   5 -
> > > >  arch/powerpc/platforms/cell/Makefile      |   3 -
> > > >  arch/powerpc/platforms/cell/qpace_setup.c | 148 ------------------------------
> > > >  5 files changed, 159 deletions(-)
> > > >  delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c
> > > 
> > > There one more reference to qpace in the file
> > >  Documentation/devicetree/bindings/serial/8250.txt
> > > ... you might want to remove that, too.
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

Ah thanks for checking.

OK agreed.

Rashmica can you send a v2 with the reference in Documentation removed, thanks.

cheers
