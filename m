Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A4DA6DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Oct 2008 18:49:15 +1100 (EST)
Date: Mon, 6 Oct 2008 09:49:10 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: Before adding preiliminary support for Netstal HCU4 (PPC405
	based) board
In-Reply-To: <200809302256.00350.niklaus.giger@member.fsf.org>
Message-ID: <Pine.LNX.4.64.0810060948090.27914@vixen.sonytel.be>
References: <200809302256.00350.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1094596141-1223279350=:27914"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1094596141-1223279350=:27914
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Sep 2008, Niklaus Giger wrote:
> The patch is against the master git of denx.de. It does not apply cleanly
> against linus' git as I cannot find there any include/asm-ppc subdirectory. 

{arch/,include-asm-}ppc/ has been removed, in favor of arch/powerpc/.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1094596141-1223279350=:27914--
