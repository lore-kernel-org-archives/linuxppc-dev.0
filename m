Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B80F1B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 19:29:45 +1000 (EST)
Date: Mon, 24 Aug 2009 11:29:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Sachin Sant <sachinp@in.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH for 2.6.31] powerpc/ps3: Add missing check for PS3 to
	rtc-ps3 platform device registration
In-Reply-To: <4A925838.2090201@in.ibm.com>
Message-ID: <alpine.LRH.2.00.0908241128470.31587@vixen.sonytel.be>
References: <4A923AD3.1020507@in.ibm.com> <1251099552.19818.4.camel@concordia>
	<alpine.LRH.2.00.0908241053190.31587@vixen.sonytel.be>
	<4A925838.2090201@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Aug 2009, Sachin Sant wrote:
> Geert Uytterhoeven wrote:
> > On non-PS3, we get:
> >
> > | kernel BUG at drivers/rtc/rtc-ps3.c:36!
> >
> > because the rtc-ps3 platform device is registered unconditionally in a
> > kernel
> > with builtin support for PS3.
> >
> > Reported-by: Sachin Sant <sachinp@in.ibm.com>
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > ---
> >  arch/powerpc/platforms/ps3/time.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> Thanks, boots fine now.
> 
> Tested-by : Sachin Sant <sachinp@in.ibm.com>

Thanks for testing! We want this for 2.6.30-stable, too.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
