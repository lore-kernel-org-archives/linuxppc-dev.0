Return-Path: <zajec5@gmail.com>
Received: from mail-we0-x232.google.com (mail-we0-x232.google.com
 [IPv6:2a00:1450:400c:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 752EE2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 06:23:14 +1000 (EST)
Received: by mail-we0-f178.google.com with SMTP id u57so1768389wes.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 13:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130919212235.GD12758@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
Date: Thu, 26 Sep 2013 22:23:08 +0200
Message-ID: <CACna6rxkpYzdD8_Jfi22vA2suUa3k-JM65_gCySQpp4crVCoPg@mail.gmail.com>
Subject: Re: [PATCH 00/51] DMA mask changes
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
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

2013/9/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> This email is only being sent to the mailing lists in question, not to
> anyone personally.  The list of individuals is far to great to do that.
> I'm hoping no mailing lists reject the patches based on the number of
> recipients.

Huh, I think it was enough to send only 3 patches to the b43-dev@. Like:
[PATCH 01/51] DMA-API: provide a helper to set both DMA and coherent DMA ma=
sks
[PATCH 14/51] DMA-API: net: b43: (...)
[PATCH 15/51] DMA-API: net: b43legacy: (...)
;)

I believe Joe has some nice script for doing it that way. When fixing
some coding style / formatting, he sends only related patches to the
given ML.

--=20
Rafa=C5=82
