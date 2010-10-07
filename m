Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3D09B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 19:03:28 +1100 (EST)
Subject: Re: Linux on ppc440gp
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <201010070932.56438.sr@denx.de>
References: <C8D1D750.272D%Jacob.Gorelik@jpl.nasa.gov>
	<1286409104.2463.373.camel@pasglop>  <201010070932.56438.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 19:03:09 +1100
Message-ID: <1286438589.2463.380.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, "Gorelik,
	Jacob \(335F\)" <jacob.gorelik@jpl.nasa.gov>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-10-07 at 09:32 +0200, Stefan Roese wrote:
> On Thursday 07 October 2010 01:51:44 Benjamin Herrenschmidt wrote:
> > On Wed, 2010-10-06 at 07:35 -0700, Gorelik, Jacob (335F) wrote:
> > > UIC0 (32 IRQ sources) at DCR 0xc0
> > > UIC1 (32 IRQ sources) at DCR 0xd0
> > 
> > That looks bad. Your device-tree probably. Check the DCR bindings.
> 
> Why does this look bad? On 440EPx this looks like this:

Because of the shit in my eyes :-) I misread 0x00 for some reason...

> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0
> UIC2 (32 IRQ sources) at DCR 0xe0
> 
> So I don't see a problem with the output above.

Right, me neither now that I had a shower !

Cheers,
Ben.
