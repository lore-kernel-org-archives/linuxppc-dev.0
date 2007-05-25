Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E179FDDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 07:04:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Date: Fri, 25 May 2007 23:04:29 +0200
References: <20070525083607.784351000@sonycom.com>
	<200705251850.30342.arnd@arndb.de>
	<Pine.LNX.4.62.0705252135010.2657@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705252135010.2657@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705252304.30396.arnd@arndb.de>
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

On Friday 25 May 2007, Geert Uytterhoeven wrote:
> 
> > What is the problem? Is there infrastructure missing in the
> > CD-ROM layer?
> 
> As the CD/DVD/BD part just accepts SCSI/ATAPI commands (except for plain
> read/write), I was suggested to keep it as a SCSI driver.

Ok, so I guess the tradeoff here is that by writing it as a SCSI
driver, you don't need to implement any of the cdrom_device_ops
yourself but instead need to fake a few of the SCSI commands
in ps3rom_request(). Fair enough.

	Arnd <><
