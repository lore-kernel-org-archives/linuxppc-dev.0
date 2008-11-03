Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 52F34DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 00:42:08 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Mon, 3 Nov 2008 14:40:39 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<1225709863.8004.252.camel@pasglop> <200811031254.24713.sr@denx.de>
In-Reply-To: <200811031254.24713.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811031440.40199.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 November 2008 12:54, Stefan Roese wrote:
> On Monday 03 November 2008, Benjamin Herrenschmidt wrote:
> > On Mon, 2008-11-03 at 10:10 +0100, Matthias Fuchs wrote:
> > > Adding this interrupt to the PCI node would make (logical) sense. But
> > > on PCI adapter (add-in cards) designs we typically disable the PCI node
> > > of the DT to disable PCI PnP. This should not prevent us from adding the
> > > interrupt to the node but it looks a little bit weird to take an
> > > interrupt from a disabled node, right?
> >
> > You can make a pci-endpoint node that isn't detected as a host bridge.
> > In fact, I think we have some way to even tell in the DT not to activate
> > host bridge function on 44x nowadays no ? I dont remember for sure but
> > it's easy enough to add.
> 
> Yes, it's there. But "only" for PCIe and not for PCI(-X). This patch added it 
> for PCIe:
> 
>     [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
>     
> It should be easy to add this for PCI and PCI-X as well.
Yes, I already though about that. Currently I set the status attribute of the pci node
to "disabled" when running as endpoint.

But adding endpoint support similiar as you did for PCIe makes sense to me.

Matthias
