Return-Path: <SRS0=/YIh=RE=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 31172DDFFF
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 20:56:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Date: Thu, 13 Dec 2007 10:56:04 +0100
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<200712131042.48354.sr@denx.de>
In-Reply-To: <200712131042.48354.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712131056.04301.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 December 2007, Stefan Roese wrote:
> On Thursday 13 December 2007, Benjamin Herrenschmidt wrote:
> > This makes 4xx embedded platforms re-assign all PCI resources as we
> > pretty much never care about what the various firmwares have done on
> > these, it's generally not compatible with the way the kernel will map
> > the bridges.
> >
> > We still need to also enable bus renumbering on some of them, but I
> > will do that from a separate patch after I've fixed 4xx PCIe to handle
> > all bus numbers.
>
> I just applied this series on top of Paulus's for-2.6.25 branch and I
> get the following error:
>
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilaue
>a.c: In function 'kilauea_probe':
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilaue
>a.c:49: error: 'ppc_pci_flags' undeclared (first use in this function)
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilaue
>a.c:49: error: (Each undeclared identifier is reported only once
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilaue
>a.c:49: error: for each function it appears in.)
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilaue
>a.c:49: error: 'PPC_PCI_REASSIGN_ALL_RSRC' undeclared (first use in this
> function) make[3]: *** [arch/powerpc/platforms/40x/kilauea.o] Error 1

Sorry for the noise, but this was my problem. I didn't apply Ben's PCI patch 
series.

Ciao,
Stefan
