Return-Path: <SRS0+ad8f260a5d864d237ed6+1391+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD7F4DDF90
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 00:36:14 +1000 (EST)
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
From: David Woodhouse <dwmw2@infradead.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20070615120848.352093000@pademelon.sonytel.be>
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.352093000@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 15:35:59 +0100
Message-Id: <1181918159.25228.543.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-15 at 13:39 +0200, Geert Uytterhoeven wrote:
> Add a Disk Storage Driver for the PS3:
>   - Implemented as a block device driver with a dynamic major
>   - Disk names (and partitions) are of the format ps3d%c(%u)
>   - Uses software scatter-gather with a 64 KiB bounce buffer as the hypervisor
>     doesn't support scatter-gather

Any particular reason why this is done as a separate block device driver
rather than as SCSI?

-- 
dwmw2
