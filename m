Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 97988DDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 02:58:42 +1000 (EST)
Date: Tue, 16 Oct 2007 18:58:33 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: ioctl32: Unknown cmd
Message-ID: <20071016165833.GB9942@kernel.dk>
References: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16 2007, Geert Uytterhoeven wrote:
> 	Hi Arnd, Jens,
> 
> The recent (post 2.6.23) changes to compat_ioctl made the reporting of
> unsupported ioctls more verbose. E.g. on the PS3 I get:
> 
> | ioctl32(cdrom_id:608): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg(00000000) on /dev/.tmp-11-0
> | ioctl32(hdparm:1427): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(00000000) on /dev/ps3da
> | ioctl32(hdparm:1427): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(00000000) on /dev/ps3da
> 
> The first one is triggered by the detection of the CD/DVD/BD-ROM driver,
> The others are triggered by me running hdparm.
> 
> Was this intentional?

Nope, not intential to me at least. I'll check up on it.

-- 
Jens Axboe
