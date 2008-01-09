Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7A130DDF6B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 21:41:54 +1100 (EST)
Date: Wed, 9 Jan 2008 11:41:52 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 4/4 v2] PS3: Add logical performance monitor driver support
In-Reply-To: <47846B48.5000003@am.sony.com>
Message-ID: <Pine.LNX.4.64.0801091141140.1492@vixen.sonytel.be>
References: <477EF59C.2070809@am.sony.com> <47846B48.5000003@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1695894257-1199875312=:1492"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
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

---584349381-1695894257-1199875312=:1492
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 8 Jan 2008, Geoff Levand wrote:
> --- /dev/null
> +++ b/drivers/ps3/ps3-lpm.c

> +	/*
> +	 * As per the PPE book IV, to avoid bookmark lost there must
                                                     ^^^^
						     loss?

> +	 * not be a traced branch within 10 cycles of setting the
> +	 * SPRN_BKMK register.  The actual text is unclear if 'within'
> +	 * includes cycles before the call.
> +	 */

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
---584349381-1695894257-1199875312=:1492--
