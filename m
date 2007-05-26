Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B9839DDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 18:52:22 +1000 (EST)
Date: Sat, 26 May 2007 10:52:20 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
In-Reply-To: <1180133119.19517.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0705261052110.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<20070525112414.GA32336@aepfle.de>
	<1180133119.19517.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 May 2007, Benjamin Herrenschmidt wrote:
> On Fri, 2007-05-25 at 13:24 +0200, Olaf Hering wrote:
> > On Fri, May 25, Geert.Uytterhoeven@sonycom.com wrote:
> > 
> > > +++ b/drivers/scsi/ps3rom.c
> > 
> > > +			kaddr = kmap_atomic(sgpnt->page, KM_USER0);
> > 
> > linux/highmem.h is not included to get the kmap_* prototypes.
> 
> Beside, I don't see the point of using kmap on ppc64...

So what should I use instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
