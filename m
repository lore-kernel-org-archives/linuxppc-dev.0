Return-Path: <olaf@aepfle.de>
Date: Thu, 5 Mar 2009 19:12:37 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing
	video RAM as block device
Message-ID: <20090305181237.GA7355@aepfle.de>
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<AA44F8E7-5FBC-4378-A86D-C094ECABD625@aepfle.de>
	<alpine.LRH.2.00.0903050856490.26681@vixen.sonytel.be>
	<alpine.LRH.2.00.0903051123240.2618@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LRH.2.00.0903051123240.2618@vixen.sonytel.be>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org,
	Vivien Chappelier <vivien.chappelier@free.fr>,
	David Woodhouse <dwmw2@infradead.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 05, Geert Uytterhoeven wrote:

> On Thu, 5 Mar 2009, Geert Uytterhoeven wrote:
> > On Thu, 5 Mar 2009, Olaf Hering wrote:
> > > I see our old mtddriver does not have modalias support for autoloading.
> > 
> > You forgot to backport commit 0a2d15b928e0b1673d4ed5f48d95af211b6fcc06
> > ("mtd/ps3vram: Add modalias support to the ps3vram driver") to the openSuSE
> > tree?
> 
> Or do you mean that udev doesn't load mtdblock automatically?

I have not tried current kernels.
Our older versions of mtd based ps3vram do not have the autoloading feature.

So, please merge the block based ps3vram.ko.

Thanks for pushing it into mainline.

Olaf
