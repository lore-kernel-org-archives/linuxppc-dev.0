Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D87A1DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 17:51:53 +1000 (EST)
Date: Wed, 8 Aug 2007 09:51:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Fix more section mismatches in head_64.S
In-Reply-To: <20070731164413.0421b430.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.62.0708080951220.24807@pademelon.sonytel.be>
References: <20070731164413.0421b430.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1941930714-1186559512=:24807"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
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

---584337861-1941930714-1186559512=:24807
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 31 Jul 2007, Stephen Rothwell wrote:
> WARNING: vmlinux.o(.text+0x8174): Section mismatch: reference to .init.text:.prom_init (between '.__boot_from_prom' and '.__after_prom_start')
> WARNING: vmlinux.o(.text+0x8498): Section mismatch: reference to .init.text:.early_setup (between '.start_here_multiplatform' and '.start_here_common')
> WARNING: vmlinux.o(.text+0x8514): Section mismatch: reference to .init.text:.setup_system (between '.start_here_common' and 'system_call_common')
> WARNING: vmlinux.o(.text+0x8530): Section mismatch: reference to .init.text:.start_kernel (between '.start_here_common' and 'system_call_common')
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Nice, the last few section warnings in my PS3 build went away!

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

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
---584337861-1941930714-1186559512=:24807--
