Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D817DB7DC6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 13:03:01 +1000 (EST)
Subject: Re: 440SPe/Katmai PCIe problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1273632013.21352.88.camel@pasglop>
References: <1273632013.21352.88.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 13:02:46 +1000
Message-ID: <1273633366.21352.100.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Pravin Bathija <pbathija@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-12 at 12:40 +1000, Benjamin Herrenschmidt wrote:
> Hi Stefan !
> 
> (Or somebody from AMCC)
> 
> I noticed we still have this old problem on PCIe where some cards don't
> seem to work. The link trains but they don't respond on config space.
> This is the case for example of that Sunix quad USB card. It seems to be
> related to the kind of TI PCIe <-> PCI bridge on these though.
> 
> Have anybody tracked down the root cause of the problem ? Some say that
> it could be that the bridge doesn't cope with the double reset (uboot
> then kernel). Would it be possible to tell uboot to avoid touching the
> PCIe interface completely so the kernel is the first one to get in ?

Actually... the card works in the Canyonlands using the latest u-boot
from ftp.denx.de (u-boot-nand.bin-2009.11.1), though interestingly
enough, this u-boot fails to detect an XGI Z11 video card that I have,
whichever slot I put it in.

in fact, the kernel itself detects the card and times out trying to get
a link. It works with whatever u-boot I used to have in there (and no
longer do ... oops :-)

Cheers,
Ben.
