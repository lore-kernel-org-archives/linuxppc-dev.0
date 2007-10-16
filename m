Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 16E4BDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 08:24:00 +1000 (EST)
Date: Tue, 16 Oct 2007 15:24:04 -0700 (PDT)
Message-Id: <20071016.152404.35664335.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: ioctl32: Unknown cmd
From: David Miller <davem@davemloft.net>
In-Reply-To: <200710162150.37636.arnd@arndb.de>
References: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
	<200710162150.37636.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, jens.axboe@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Oct 2007 21:50:35 +0200

> The one point where it is expected to have changed now is when you
> try to do these ioctls on something that is not a block device. Are
> you sure that the files you tried them on were created correctly?

Many many many programs do this exact sort of thing.

It is one of the bad aspects of moving the compat handling
down into the file ops for a specific device.
