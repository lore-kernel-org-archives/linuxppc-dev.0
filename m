Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 497FEDDFB6
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:26:32 +1000 (EST)
Date: Tue, 7 Apr 2009 09:26:30 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Keep track of emulated instructions 
In-Reply-To: <12794.1239057838@neuling.org>
Message-ID: <alpine.LRH.2.00.0904070926001.17130@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
	<3DA386C6-F26A-4929-8609-FE468DF01572@kernel.crashing.org>
	<alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be>
	<12794.1239057838@neuling.org>
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

On Tue, 7 Apr 2009, Michael Neuling wrote:
> In message <alpine.LRH.2.00.0904061430090.11076@vixen.sonytel.be> you wrote:
> > On Fri, 3 Apr 2009, Kumar Gala wrote:
> > > On Apr 3, 2009, at 7:08 AM, Geert Uytterhoeven wrote:
> > > >Finally (after ca. 1.5 years), he're an updated version of my patch to k=
> > eep
> > > >track of emulated instructions.  In the light of Kumar's `Emulate enough=
> >  of
> > > >SPE
> > > >instructions to make gcc happy' patch, he probably also wants to keep tr=
> > ack
> > > >of
> > > >the actual runtime overhead.
> > > >
> > > >Changes since last version:
> > > > - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provi=
> > de
> > > >   counters in sysfs on ppc32, too,
> > > > - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
> > > > - Add warnings for altivec,
> > > > - Add warnings for recently introduced emulation of vsx and isel
> > > >   instructions.
> > > =
> > 
> > > pretty cool.  Do we think counters should be sysfs or debugfs?
> > 
> > What do you prefer?
> > 
> > On MIPS, unaligned exception handling control is in debugfs.
> 
> Would per process counters be too hard?  Stick them in the thread_struct
> and export them via /proc/<pid>/emulated. 

But they go away as soon as the process exits, right?

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
