Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D61B82C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 00:13:54 +1000 (EST)
Date: Fri, 20 Sep 2013 15:12:44 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH 01/51] DMA-API: provide a helper to set both DMA and
 coherent DMA masks
Message-ID: <20130920141244.GQ25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
 <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 b43-dev@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
 linux-crypto@vger.kernel.org, Rob Landley <rob@landley.net>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 20, 2013 at 02:21:37AM +0100, Ben Hutchings wrote:
> On Thu, 2013-09-19 at 22:25 +0100, Russell King wrote:
> [...]
> > -dma_set_coherent_mask() will always be able to set the same or a
> > -smaller mask as dma_set_mask(). However for the rare case that a
> > +The coherent coherent mask will always be able to set the same or a
> > +smaller mask as the streaming mask. However for the rare case that a
> [...]
> 
> The new wording doesn't make sense; a mask doesn't set itself.  I would
> suggest:
> 
> "The coherent mask can always be set to the same or a smaller mask than
> the streaming mask."

Yes, the original sentence is not particularly good, but I think even
your modified version can be interpreted as "a mask setting itself"
for all the same reasons that the original can be (which mask does "same"
refer to?)

Even so, I prefer your version.  Thanks. :)
