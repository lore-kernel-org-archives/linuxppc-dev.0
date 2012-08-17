Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 352E82C007C
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 07:39:06 +1000 (EST)
Message-ID: <1345239504.11781.3.camel@pasglop>
Subject: Re: PPC64 & DMA zone
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 18 Aug 2012 07:38:24 +1000
In-Reply-To: <20120817210117.GB1908@harshnoise.musicnaut.iki.fi>
References: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
 <1345236056.11781.1.camel@pasglop>
 <20120817210117.GB1908@harshnoise.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-08-18 at 00:01 +0300, Aaro Koskinen wrote:
> b43-pci-bridge 0001:01:01.0: Warning: IOMMU window too big for device
> mask
> b43-pci-bridge 0001:01:01.0: mask: 0x3fffffff, table end: 0x80000000
> b43-phy0 ERROR: The machine/kernel does not support the required
> 30-bit DMA mask

Hrm, odd, I though we had the iommu allocator sorted to handle that case
a while back. Maybe that got broken. I can try to have a look but poke
me in a week or so if you don't hear from me.

Unless somebody else beat me to it which would be much welcome :-)

Cheers,
Ben.
