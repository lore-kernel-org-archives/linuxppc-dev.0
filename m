Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E153DDDD05
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:31:51 +1000 (EST)
Date: Fri, 13 Jul 2007 11:31:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>,
	"James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [patch 0/6] PS3 Storage Drivers for 2.6.23, take 4
In-Reply-To: <Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0707131129500.18802@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707100944470.22782@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1399021359-1184319102=:18802"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1399021359-1184319102=:18802
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0707131131471.18802@pademelon.sonytel.be>

On Tue, 10 Jul 2007, Geert Uytterhoeven wrote:
> On Wed, 4 Jul 2007, Geert Uytterhoeven wrote:
> > This is the fourth submission of the new PS3 storage drivers:
> >   [1] ps3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
> >   [2] ps3: Storage Driver Core
> >   [3] ps3: Storage device registration routines.
> >   [4] ps3: Disk Storage Driver
> >   [5] ps3: BD/DVD/CD-ROM Storage Driver
> >   [6] ps3: FLASH ROM Storage Driver
> > 
> > They are based on:
> >   - the current Linux kernel source tree,
> >   - plus the PS3 patches already submitted by Geoff Levand on linuxppc-dev,
> >   - plus the shost_priv() patch in scsi-misc (commit
> >     bcd92c9fbcc679ee95003083056f0441a1f474fa).
> > 
> > All issues raised during the previous review rounds should be fixed.
> > There were no more comments after the third submission.
> > 
> > Paul already integrated Geoff Levand's PS3 patches and the first 3 patches
> > in this series in the for-2.6.23 branch in powerpc.git.
> > 
> > Maintainers of block/SCSI/misc, can you please ack the last 3 patches so Paul
> > can take them, too?
> 
> Ping block/SCSI/misc maintainers?

Ping SCSI and misc maintainers?

Please either ack patches 5 and 6, so Paulus can integrate them for 2.6.23, or
tell me why they can't go in.

Thanks again.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1399021359-1184319102=:18802--
