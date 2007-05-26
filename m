Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D7BBDDEE3
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 08:17:58 +1000 (EST)
Subject: Re: [patch 1/7] ps3: Preallocate bootmem memory for the PS3 FLASH
	ROM storage driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705261050140.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.177254000@sonycom.com>
	<1180132539.19517.2.camel@localhost.localdomain>
	<Pine.LNX.4.62.0705261050140.2657@pademelon.sonytel.be>
Content-Type: text/plain
Date: Sun, 27 May 2007 08:17:50 +1000
Message-Id: <1180217870.19517.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-26 at 10:51 +0200, Geert Uytterhoeven wrote:
> 
> I know.
> 
> Do you know another way to allocate an aligned chunk of 256 KiB of
> physically
> contiguous memory, possibly a long time after boot up?

kmalloc & a good prayer ? :-0

Ben.
