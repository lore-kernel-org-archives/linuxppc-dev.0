Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 578B7DDD08
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 23:34:20 +1000 (EST)
Date: Fri, 13 Jul 2007 15:34:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: PS3 Storage Driver O_DIRECT issue
In-Reply-To: <20070713122752.GA854@aepfle.de>
Message-ID: <Pine.LNX.4.62.0707131532350.18802@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<20070713122752.GA854@aepfle.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1147011636-1184333658=:18802"
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
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

---584337861-1147011636-1184333658=:18802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 13 Jul 2007, Olaf Hering wrote:
> This driver (or the generic PS3 code) has appearently problems with
> O_DIRECT. 
> glibc aborts parted because the malloc metadata get corrupted. While it
> is reproducible, the place where it crashes changes with every version
> of the debug attempt.
> I dont have a handle right now, all I know is that the metadata after a
> malloc area get overwritten with zeros.
> 
> 
> Can you have a look at this? 
> parted /dev/ps3da
> print (a few times)

I can't seem to reproduce this with parted 1.7.1-5.1 (from Debian
etch/lenny/sid) and kernel 2.6.22-g77320894.

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
---584337861-1147011636-1184333658=:18802--
