Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 09470DDF4B
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:15:19 +1000 (EST)
Date: Tue, 29 May 2007 11:15:14 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] remove geometry support from ps3 storage driver
In-Reply-To: <20070521143938.GA20321@lst.de>
Message-ID: <Pine.LNX.4.62.0705291114340.7698@pademelon.sonytel.be>
References: <20070521125311.GA27626@aepfle.de> <20070521143938.GA20321@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 May 2007, Christoph Hellwig wrote:
> On Mon, May 21, 2007 at 02:53:11PM +0200, Olaf Hering wrote:
> > The old ps3_storage driver did not support DOS geometry, so there is no
> > point to start adding code for it.
> 
> That's not quite true.  sd applies some heuristics  and has a default
> geometry if there is no ->bios_param method.  Then again this whole
> gemetry thing really only makes sense on x86.

Would it make sense to have a default implementation in block/ioctl.c?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
