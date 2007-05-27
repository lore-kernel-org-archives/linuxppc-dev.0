Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 25AFADDED8
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 04:26:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/7] ps3: Preallocate bootmem memory for the PS3 FLASH ROM
	storage driver
Date: Sun, 27 May 2007 20:24:57 +0200
References: <20070525083607.784351000@sonycom.com>
	<Pine.LNX.4.62.0705261050140.2657@pademelon.sonytel.be>
	<1180217870.19517.39.camel@localhost.localdomain>
In-Reply-To: <1180217870.19517.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705272024.57460.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 27 May 2007, Benjamin Herrenschmidt wrote:
> On Sat, 2007-05-26 at 10:51 +0200, Geert Uytterhoeven wrote:
> > Do you know another way to allocate an aligned chunk of 256 KiB of
> > physically
> > contiguous memory, possibly a long time after boot up?
> 
> kmalloc & a good prayer ? :-0

s/kmalloc/get_free_pages/

kmalloc is limited to 128kb.

	Arnd <><
