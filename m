Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 5 Mar 2009 11:24:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing video
	RAM as block device
In-Reply-To: <alpine.LRH.2.00.0903050856490.26681@vixen.sonytel.be>
Message-ID: <alpine.LRH.2.00.0903051123240.2618@vixen.sonytel.be>
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<AA44F8E7-5FBC-4378-A86D-C094ECABD625@aepfle.de>
	<alpine.LRH.2.00.0903050856490.26681@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
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

On Thu, 5 Mar 2009, Geert Uytterhoeven wrote:
> On Thu, 5 Mar 2009, Olaf Hering wrote:
> > I see our old mtddriver does not have modalias support for autoloading.
> 
> You forgot to backport commit 0a2d15b928e0b1673d4ed5f48d95af211b6fcc06
> ("mtd/ps3vram: Add modalias support to the ps3vram driver") to the openSuSE
> tree?

Or do you mean that udev doesn't load mtdblock automatically?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
