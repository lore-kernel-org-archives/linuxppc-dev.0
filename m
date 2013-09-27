Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 089782C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:33:16 +1000 (EST)
Date: Fri, 27 Sep 2013 09:27:04 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH 00/51] DMA mask changes
Message-ID: <20130927082703.GZ25647@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <CACna6rxkpYzdD8_Jfi22vA2suUa3k-JM65_gCySQpp4crVCoPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACna6rxkpYzdD8_Jfi22vA2suUa3k-JM65_gCySQpp4crVCoPg@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 linux-samsung-soc@vger.kernel.org,
 Linux SCSI List <linux-scsi@vger.kernel.org>,
 e1000-devel@lists.sourceforge.net, b43-dev <b43-dev@lists.infradead.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Network Development <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 10:23:08PM +0200, Rafał Miłecki wrote:
> 2013/9/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > This email is only being sent to the mailing lists in question, not to
> > anyone personally.  The list of individuals is far to great to do that.
> > I'm hoping no mailing lists reject the patches based on the number of
> > recipients.
> 
> Huh, I think it was enough to send only 3 patches to the b43-dev@. Like:
> [PATCH 01/51] DMA-API: provide a helper to set both DMA and coherent DMA masks
> [PATCH 14/51] DMA-API: net: b43: (...)
> [PATCH 15/51] DMA-API: net: b43legacy: (...)
> ;)
> 
> I believe Joe has some nice script for doing it that way. When fixing
> some coding style / formatting, he sends only related patches to the
> given ML.

If I did that, then the mailing lists would not get the first patch,
because almost none of the lists would be referred to by patch 1.

Moreover, people complain when they don't have access to the full
patch series - they assume patches are missing for some reason, and
they ask for the rest of the series.
