Return-Path: <htejun@gmail.com>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A8DC2C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 22:17:04 +1000 (EST)
Received: by mail-yh0-f48.google.com with SMTP id f10so84427yha.35
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 05:17:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 20 Sep 2013 07:16:52 -0500
From: Tejun Heo <tj@kernel.org>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
Message-ID: <20130920121652.GA7630@mtj.dyndns.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-mmc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-ide@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net,
 Seung-Woo Kim <sw0312.kim@samsung.com>, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
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

On Fri, Sep 20, 2013 at 12:11:38AM +0100, Russell King wrote:
> The correct way for a driver to specify the coherent DMA mask is
> not to directly access the field in the struct device, but to use
> dma_set_coherent_mask().  Only arch and bus code should access this
> member directly.
> 
> Convert all direct write accesses to using the correct API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tejun Heo <tj@kernel.org>

The patch is pretty widely spread.  I don't mind how it gets routed
but what's the plan?

Thanks.

-- 
tejun
