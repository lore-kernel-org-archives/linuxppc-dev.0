Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C59D2C0377
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 14:47:19 +1000 (EST)
Message-ID: <1370580426.3766.349.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-R61911 <r61911@freescale.com>
Date: Fri, 07 Jun 2013 14:47:06 +1000
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 04:45 +0000, Zang Roy-R61911 wrote:
> 
> > Forget it, reset all the jumpers to the default setup (found the doc !)
> > and they come up now in slot 4 and 7. It also looks like uBoot now has an
> > e1000 driver so I don't have to use fman (for which I believe there is
> > still no upstream driver right ?)

> fman in u-boot has been up streamed.  It should work.

I don't care much about u-boot :-) It's the kernel that matters to me.

> > 
> > BTW. Is that normal during boot ?
> > 
> > Net:   Initializing Fman
> > Fman1: Uploading microcode version 106.1.7 PHY reset timed out PHY reset
> > timed out PHY reset timed out PHY reset timed out
> You can ignore the timeout. 
> Do you plug other card (for example SGMII card) on the board?

No, only PCIe in slot 4 and 7.

> u-boot detects some card in the slot and tries to init the PHY but fails.

Cheers,
Ben.
