Return-Path: <SRS0=QhAZ=NY=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A1B31DDEDB
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 15:55:13 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Add pci node to sequoia dts
Date: Mon, 27 Aug 2007 07:56:42 +0200
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092954.4087.95333.stgit@localhost.localdomain>
	<15d18697dc6fe8e930deb1880daad3b6@kernel.crashing.org>
In-Reply-To: <15d18697dc6fe8e930deb1880daad3b6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708270756.42485.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 25 August 2007, Segher Boessenkool wrote:
> > +			compatible = "ibm, 440epx";
>
> Oh, and shouldn't it be "amcc," anyway?

Not sure here. It's still the PCI core used on the early 405 and 440 platforms 
build by IBM. If we use IBM on other core logic like UIC, EMAC etc, then we 
should use IBM here too.

Best regards,
Stefan
