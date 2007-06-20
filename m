Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D6A9CDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 17:41:52 +1000 (EST)
Date: Wed, 20 Jun 2007 09:41:47 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH/RFC] Make certain timekeeping variables __read_mostly
In-Reply-To: <20070620031333.GP9768@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.62.0706200940260.27011@pademelon.sonytel.be>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
	<20070620031333.GP9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2044335871-1182325307=:27011"
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
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

---584337861-2044335871-1182325307=:27011
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 20 Jun 2007, Tony Breeds wrote:
> On Wed, Jun 20, 2007 at 12:02:11PM +1000, Tony Breeds wrote:
> > Also this patch makes tb_to_ns_scale and tb_to_ns_shift static for good
> > measure.
> 
> While we're ate it these 3 variables can be marked __read_mostly.

There's no __read_mostly support for powerpc yet (is there?), so __read_mostly
just expands to nothing?

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
---584337861-2044335871-1182325307=:27011--
