Return-Path: <mdaniels@lanl.gov>
Received: from proofpoint1.lanl.gov (proofpoint1.lanl.gov [204.121.3.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1889DDDB2
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 12:02:23 +1100 (EST)
Message-ID: <49AF1B16.5000907@lanl.gov>
Date: Wed, 04 Mar 2009 17:21:42 -0700
From: "Marcus G. Daniels" <mdaniels@lanl.gov>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] [PATCH/RFC] ps3/block: Add ps3vram-ng driver for
	accessing video RAM as block device
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org,
	Vivien Chappelier <vivien.chappelier@free.fr>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> Ideally, we think it would be best if the existing MTD-based ps3vram driver
> would be replaced by the new block-based ps3vram driver before 2.6.29 is
> released. This would relieve the burden of supporting two different swap space
> schemes on PS3 (swap on /dev/mtdblock0 vs. /dev/ps3vram) from the distro
> maintainer's shoulders, as in that case there would never have been a stable
> kernel version containing the MTD-based ps3vram driver.
> [..]
>   - ps3vram-ng is faster than ps3vram:
>       o 1 MiB blocks: +50% (read), +5% (write)
>       o 4 KiB blocks: +50% (read), +5% (write)
>       o 512 B blocks: +10% (read), +10% (write)
>   
Fwiw, it's a useful swap device, since space is so limited -- the 
performance improvements are certainly appealing too.

Marcus
