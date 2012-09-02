Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 21A862C008C
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Sep 2012 13:13:07 +1000 (EST)
Message-ID: <1346555568.3025.0.camel@pasglop>
Subject: Re: PPC64 & DMA zone
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sun, 02 Sep 2012 13:12:48 +1000
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B708019EB2@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
 <1345236056.11781.1.camel@pasglop>
 <6AE080B68D46FC4BA2D2769E68D765B708019EB2@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-09-02 at 02:54 +0000, Tabi Timur-B04825 wrote:
> On Fri, Aug 17, 2012 at 3:40 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Fri, 2012-08-17 at 23:04 +0300, Aaro Koskinen wrote:
> >> Hi,
> >>
> >> Is there a way to reduce/limit DMA zone with PPC64 kernel (3.6-rcX)
> >> on G5 Mac? I have tried to search Kconfig or command line options,
> >> but can't find anything.
> >
> > No.
> 
> What about Shaohui patches for ZONE_DMA?  That's meant to solve
> exactly this problem?  Granted, it sets the DMA zone to 31 bits, but
> it's simple to hack that to 30 bits.

Unnecessary for this specific problem. The right fix to the iommu code
has already been done.

Cheers,
Ben.
