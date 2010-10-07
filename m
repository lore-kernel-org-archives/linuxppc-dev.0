Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BE0FB70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 18:33:16 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux on ppc440gp
Date: Thu, 7 Oct 2010 09:32:56 +0200
References: <C8D1D750.272D%Jacob.Gorelik@jpl.nasa.gov>
	<1286409104.2463.373.camel@pasglop>
In-Reply-To: <1286409104.2463.373.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201010070932.56438.sr@denx.de>
Cc: "Gorelik, Jacob \(335F\)" <jacob.gorelik@jpl.nasa.gov>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 07 October 2010 01:51:44 Benjamin Herrenschmidt wrote:
> On Wed, 2010-10-06 at 07:35 -0700, Gorelik, Jacob (335F) wrote:
> > UIC0 (32 IRQ sources) at DCR 0xc0
> > UIC1 (32 IRQ sources) at DCR 0xd0
> 
> That looks bad. Your device-tree probably. Check the DCR bindings.

Why does this look bad? On 440EPx this looks like this:

UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0

So I don't see a problem with the output above.

Cheers,
Stefan
