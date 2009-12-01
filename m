Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 700CF1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 09:59:50 +1100 (EST)
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2hbsazapo.fsf@igel.home>
References: <20091201070834.6A840B7B63@ozlabs.org> <m2hbsazapo.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Dec 2009 09:58:52 +1100
Message-ID: <1259708332.2076.1041.camel@pasglop>
Mime-Version: 1.0
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 21:43 +0100, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This is a libata driver for the "macio" IDE controller used on most Apple
> > PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> 
> Tried it on my iBook G4 and I got an oops during probing, in
> pata_macio_common_init+0x378/0x614.

Bah, I know what it is ... a last minute cleanup that breaks the PCI
variants of the cell. I'll send a new patch later today along with
other fixes.

Cheers,
Ben.
