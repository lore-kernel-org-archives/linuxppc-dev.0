Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 671ECDDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 21:58:32 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0903111028480.1040@vixen.sonytel.be>
References: <1236729444.7086.24.camel@pasglop>
	<alpine.LRH.2.00.0903111028480.1040@vixen.sonytel.be>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Mar 2009 21:57:05 +1100
Message-Id: <1236769025.7086.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-03-11 at 10:37 +0100, Geert Uytterhoeven wrote:
> On Wed, 11 Mar 2009, Benjamin Herrenschmidt wrote:
> > Here are some late fixes for 2.6.29. I've included a radeonfb/aty128fb commit
> 
> Will you also take care of the new ps3vram driver, which has been ack'ed by
> Jens for 2.6.29?
> Or do you prefer it to go in by email through Geoff (as PS3 maintainer), or
> from me directly?

I'd like to have Andrew or Linus opinion on doing this driver swap that
late in the process.

Ben.

> Thanks!
> 
> With kind regards,
> 
> Geert Uytterhoeven
> Software Architect
> 
> Sony Techsoft Centre Europe
> The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
> 
> Phone:    +32 (0)2 700 8453
> Fax:      +32 (0)2 700 8622
> E-mail:   Geert.Uytterhoeven@sonycom.com
> Internet: http://www.sony-europe.com/
> 
> A division of Sony Europe (Belgium) N.V.
> VAT BE 0413.825.160 · RPR Brussels
> Fortis · BIC GEBABEBB · IBAN BE41293037680010
