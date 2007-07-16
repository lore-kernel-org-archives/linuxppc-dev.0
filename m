Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 898E8DDD05
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 19:16:51 +1000 (EST)
Date: Mon, 16 Jul 2007 11:16:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: possible dead CONFIG-related content under arch/powerpc
In-Reply-To: <Pine.LNX.4.64.0707141816470.9751@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0707161116280.1072@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0707141816470.9751@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1935959558-1184577409=:1072"
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
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

---584337861-1935959558-1184577409=:1072
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 14 Jul 2007, Robert P. J. Day wrote:
> ========== SPE_BASE ==========
> arch/powerpc/mm/hash_utils_64.c:612:#ifdef CONFIG_SPE_BASE
> arch/powerpc/mm/hash_utils_64.c:747:#ifdef CONFIG_SPE_BASE

Interesting, should this one be CONFIG_SPU_BASE?

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
---584337861-1935959558-1184577409=:1072--
