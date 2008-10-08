Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 3A7B1DE04A
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 21:00:07 +1100 (EST)
Date: Wed, 8 Oct 2008 11:59:59 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
In-Reply-To: <20081008100025.1c535401@lxorguk.ukuu.org.uk>
Message-ID: <Pine.LNX.4.64.0810081159240.24611@vixen.sonytel.be>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
	<20081007103723.0224671e@lxorguk.ukuu.org.uk>
	<1223455254.3145.143.camel@macbook.infradead.org>
	<20081008100025.1c535401@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1477599591-1223459999=:24611"
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Li Yang <leoli@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>, Wang Jian <lark@linux.net.cn>
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

---584349381-1477599591-1223459999=:24611
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 8 Oct 2008, Alan Cox wrote:
> On Wed, 08 Oct 2008 09:40:54 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > On Tue, 2008-10-07 at 10:37 +0100, Alan Cox wrote:
> > > Zero means no IRQ. Any platform with bits of code left over exposing IRQ
> > > 0 is already not supported by lots of driver code including libata.
> > 
> > ...and must implement some kind of interrupt remapping crap just to work
> > around this bogus design decision.
> 
> I'll leave you to argue with Linus about that, but since that was the
> decision back in 2005 (for good C reasons) we can safely rely on it.

`git grep NO_IRQ include arch/*/include' is still quite enlightening...

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
---584349381-1477599591-1223459999=:24611--
