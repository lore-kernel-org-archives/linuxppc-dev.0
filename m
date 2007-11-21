Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id CB371DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 03:50:47 +1100 (EST)
Date: Wed, 21 Nov 2007 17:50:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
In-Reply-To: <7D40FA9E-A972-4995-85AE-3CE2551BB195@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0711211746180.12720@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<7D40FA9E-A972-4995-85AE-3CE2551BB195@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2089711096-1195663845=:12720"
Cc: linuxppc-dev@ozlabs.org
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

---584337861-2089711096-1195663845=:12720
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 21 Nov 2007, Kumar Gala wrote:
> On Nov 21, 2007, at 7:09 AM, Geert Uytterhoeven wrote:
> > On Tue, 20 Nov 2007, Kumar Gala wrote:
> > > On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:
> > > > Given that the instruction is meant to be a performance enhancement,
> > > > we should probably warn the first few times it's emulated, so the user
> > > > knows they should change their toolchain setup if possible.
> > > 
> > > The same is true of mcrxr, popcntb, and possibly string ld/st.
> > > 
> > > Feel free to submit a patch that warns about their usage.
> 
> How about some per processor counters in sysfs under the processor.

Per processor? That means it has to be per_cpu, which sounds a bit like
overkill to me.

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
---584337861-2089711096-1195663845=:12720--
