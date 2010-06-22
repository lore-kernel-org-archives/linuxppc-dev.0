Return-Path: <vapier.adi@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id BA619B6F0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 03:56:22 +1000 (EST)
Received: by gyf2 with SMTP id 2so3230705gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 10:56:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100622165734.GA20699@oksana.dev.rtsoft.ru>
References: <20100622165545.GA10255@oksana.dev.rtsoft.ru>
	<20100622165734.GA20699@oksana.dev.rtsoft.ru>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 22 Jun 2010 13:56:00 -0400
Message-ID: <AANLkTinP63VyX2LjY-zIbnluasCiT3tOv6tlfZ6k1WqM@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: m25p80: Fix false-positive probing
To: Anton Vorontsov <avorontsov@mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 22, 2010 at 12:57, Anton Vorontsov wrote:
> Since commit 18c6182bae0acca220ed6611f741034d563cd19f ("Rework
> probing/JEDEC code"), m25p80 driver successfully registers chips
> even if JEDEC probing fails.
>
> This was needed to support non-JEDEC flashes. Though, it appears
> that some platforms (e.g. blackfin bf533 stamp[1]) used the old
> behavior to detect if there's any flash connected, so the driver
> have to fail on JEDEC probing errors.
>
> This patch restores the old behavior for JEDEC flashes, and adds
> "-nonjedec" SPI device IDs for M25Pxx flashes, so that the kernel
> still supports non-JEDEC flashes.

Acked-by: Mike Frysinger <vapier@gentoo.org>

> [1] http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=5975

http://blackfin.uclinux.org/gf/tracker/5975

> Reported-by: Mingquan Pan

<Grace.Pan@analog.com>
-mike
