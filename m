Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CE1ADDF90
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:53:16 +1000 (EST)
Subject: Re: [patch 5/7] ps3: Disk Storage Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705252137230.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.575306000@sonycom.com>
	<200705251826.25572.arnd@arndb.de>
	<Pine.LNX.4.62.0705252137230.2657@pademelon.sonytel.be>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:53:08 +1000
Message-Id: <1180133588.19517.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 21:40 +0200, Geert Uytterhoeven wrote:
> 
> I used a kthread because the request function of a block device driver
> must be
> non-blocking, and ps3stor_read_write_sectors() calls
> wait_for_completion().

Which as I said before looks terribly sad... Why the heck would it have
to do that ?

Ben.
