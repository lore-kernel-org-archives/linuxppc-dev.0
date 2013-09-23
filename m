Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 420E72C010D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 21:34:33 +1000 (EST)
Date: Mon, 23 Sep 2013 16:13:52 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] [PATCH 24/51] DMA-API: dma: pl330: add
 dma_set_mask_and_coherent() call
Message-ID: <20130923104352.GK17188@intel.com>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
 <201309201926.29084.heiko@sntech.de>
 <20130921200000.GS25647@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130921200000.GS25647@n2100.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-doc@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 b43-dev@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-tegra@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 21, 2013 at 09:00:00PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 20, 2013 at 07:26:27PM +0200, Heiko Stübner wrote:
> > Am Donnerstag, 19. September 2013, 23:49:01 schrieb Russell King:
> > > The DMA API requires drivers to call the appropriate dma_set_mask()
> > > functions before doing any DMA mapping.  Add this required call to
> > > the AMBA PL08x driver.
> > 			^--- copy and paste error - should of course be PL330
> 
> Fixed, thanks.
with fixed changelog...

Acked-by: Vinod Koul <vinod.koul@intel.com>

~Vinod

-- 
