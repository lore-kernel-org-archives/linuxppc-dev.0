Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D0A8DDDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:58:00 +1000 (EST)
Date: Tue, 29 May 2007 11:57:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 7/7] ps3: FLASH ROM Storage Driver
In-Reply-To: <20070529095355.GA29351@lst.de>
Message-ID: <Pine.LNX.4.62.0705291157260.7698@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.815300000@sonycom.com>
	<20070529095355.GA29351@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 May 2007, Christoph Hellwig wrote:
> On Fri, May 25, 2007 at 10:36:14AM +0200, Geert.Uytterhoeven@sonycom.com wrote:
> > Add a FLASH ROM Storage Driver for the PS3:
> >   - Implemented as a misc character device driver
> >   - Uses a fixed 256 KiB buffer allocated from boot memory as the hypervisor
> >     requires the writing of aligned 256 KiB blocks
> 
> Looks good, but please either make the driver aware of multiple devices
> even if they can't happen currently, or alternatively error out in
> ->probe if of some reason it's called for a second device.

ps3flash_probe() does return -EBUSY when called for a second device.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
