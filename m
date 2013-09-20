Return-Path: <htejun@gmail.com>
Received: from mail-ye0-x22f.google.com (mail-ye0-x22f.google.com
 [IPv6:2607:f8b0:4002:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDD3E2C0118
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 08:21:00 +1000 (EST)
Received: by mail-ye0-f175.google.com with SMTP id q8so372550yen.20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 15:20:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 20 Sep 2013 17:20:50 -0500
From: Tejun Heo <tj@kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
Message-ID: <20130920222050.GA8763@mtj.dyndns.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
 <20130920140018.GP25647@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130920140018.GP25647@n2100.arm.linux.org.uk>
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

Hey,

On Fri, Sep 20, 2013 at 03:00:18PM +0100, Russell King - ARM Linux wrote:
> Another would be if subsystem maintainers are happy that I carry them,
> I can add the acks, and then later on towards the end of the cycle,
> provide a branch subsystem maintainers could pull.
> 
> Or... if you can think of something easier...

I'm happy with the latter method and it's likely that you'll end up
carrying at least some of the patches through your tree anyway.
Please feel free to add my acks to all libata related patches and
carry them through your tree.

Thanks and have fun routing.

-- 
tejun
