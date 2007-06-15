Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A3615DDF53
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 23:32:43 +1000 (EST)
Date: Fri, 15 Jun 2007 15:32:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/6] ps3: Preallocate bootmem memory for the PS3 FLASH
	ROM storage driver
In-Reply-To: <1181914039.26853.80.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0706151529380.14899@pademelon.sonytel.be>
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.002575000@pademelon.sonytel.be>
	<1181914039.26853.80.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1031989590-1181914361=:14899"
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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

---584337861-1031989590-1181914361=:14899
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Jun 2007, Benjamin Herrenschmidt wrote:
> On Fri, 2007-06-15 at 13:39 +0200, Geert Uytterhoeven wrote:
> > plain text document attachment (ps3-stable)
> > Preallocate 256 KiB of bootmem memory for the PS3 FLASH ROM storage driver.
> 
> I still very much dislike the #ifdef xxx_MODULE in main kernel code.

Me too, but there's no other reliable way to allocate it after boot up...

> At the end of the day, is it realistic to ever use a PS3 without the
> storage driver ? I would suggest just allocating those unconditionally.

If you don't plan to (a) boot into GameOS or (b) update the kboot kernel, then
the answer is: yes, you can live without the FLASH ROM driver, and save one
promille of RAM.

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
---584337861-1031989590-1181914361=:14899--
