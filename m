Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A77EB7B84
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 23:45:51 +1000 (EST)
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A3538DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 23:45:50 +1000 (EST)
Date: Fri, 21 Aug 2009 15:45:47 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 832x: MATH_EMUL
In-Reply-To: <1059A1F2-B4AA-48DC-82D6-B26D39414FA4@kernel.crashing.org>
Message-ID: <alpine.LRH.2.00.0908211545170.16485@vixen.sonytel.be>
References: <4A8E4128.6040905@denx.de>
	<1059A1F2-B4AA-48DC-82D6-B26D39414FA4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Aug 2009, Kumar Gala wrote:
> On Aug 21, 2009, at 1:39 AM, Heiko Schocher wrote:
> >I actually porting a mpc8321 based port, and because there is no FPU
> >on this CPU, I activated MATH_EMUL, as all other mpc832x ports did.
> >
> >Is there something like a counter, which counts how many times this
> >Exception occurs?
> 
> Geert published some patches that did something like this but there isn't
> upstream as far as I know at this point.

It's upstream: 80947e7c99c29ce3a78bdc1933b310468455a82f

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
