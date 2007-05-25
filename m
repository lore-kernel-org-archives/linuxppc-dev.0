Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 45A18DDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 05:36:42 +1000 (EST)
Date: Fri, 25 May 2007 21:36:39 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
In-Reply-To: <200705251850.30342.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0705252135010.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<200705251850.30342.arnd@arndb.de>
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

On Fri, 25 May 2007, Arnd Bergmann wrote:
> On Friday 25 May 2007, Geert.Uytterhoeven@sonycom.com wrote:
> > Add a CD/DVD/BD Storage Driver for the PS3:
> >   - Implemented as a SCSI device driver
> 
> I assume you tried implementing it as a block device driver,
> like you PS3 disk driver does, and failed for some reason.
> 
> What is the problem? Is there infrastructure missing in the
> CD-ROM layer?

As the CD/DVD/BD part just accepts SCSI/ATAPI commands (except for plain
read/write), I was suggested to keep it as a SCSI driver.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
