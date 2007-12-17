Return-Path: <SRS0=MP4y=RI=gmx.de=7eggert@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A4141DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 08:29:47 +1100 (EST)
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 1st version of azfs
To: Maxim Shchetynin <maxim@de.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Date: Mon, 17 Dec 2007 22:24:14 +0100
References: <9Btcy-1LS-23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E1J4NRf-0004mg-0G@be1.7eggert.dyndns.org>
Reply-To: 7eggert@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maxim Shchetynin <maxim@de.ibm.com> wrote:

> +config AZ_FS
> +            tristate "AZFS filesystem support"
> +            default m
                       ^
STRONG NACK, I hate digging in the menu tree and hunting for things I
don't need.

> +            help
> +              Non-buffered filesystem for block devices with a gendisk and
> +              with direct_access() method in gendisk->fops.
> +              AZFS does not buffer outgoing traffic and is doing no read
> ahead.
> +              AZFS uses block-size and sector-size provided by block
> device
> +              and gendisk's queue. Though mmap() method is available only
> if
> +              block-size equals to or is greater than system page size.

What is the benefit or intended use of this filesystem? Will your intended
user say "gendisk->fops->direct_access? I wanted to use it all my life"?

AZFZ seems to be an acronym. AirZound File System?
http://globetrotter.de/de/shop/detail.php?mod_nr=ex_35001&GTID=7c553060901a873c5bd29a1846ff39a3a32
