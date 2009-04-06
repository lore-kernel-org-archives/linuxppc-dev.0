Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A288BDDE1D
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 22:30:15 +1000 (EST)
Date: Mon, 6 Apr 2009 14:30:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions
In-Reply-To: <1238819848.9595.25.camel@localhost>
Message-ID: <alpine.LRH.2.00.0904061429370.11076@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
	<1238819848.9595.25.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 4 Apr 2009, Michael Ellerman wrote:
> On Fri, 2009-04-03 at 14:08 +0200, Geert Uytterhoeven wrote:
> > Finally (after ca. 1.5 years), he're an updated version of my patch to keep
> > track of emulated instructions.  In the light of Kumar's `Emulate enough of SPE
> > instructions to make gcc happy' patch, he probably also wants to keep track of
> > the actual runtime overhead.
> > 
> > Changes since last version:
> >   - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provide
> >     counters in sysfs on ppc32, too,
> >   - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
> >   - Add warnings for altivec,
> >   - Add warnings for recently introduced emulation of vsx and isel
> >     instructions.
> 
> You don't count instructions that fall through to the bottom of
> fix_alignment()?

Thanks! I add a generic unaligned counter for the fall through case.

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
