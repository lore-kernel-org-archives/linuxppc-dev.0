Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 4EEC9DDED4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 19:27:46 +1000 (EST)
Date: Fri, 5 Sep 2008 11:27:36 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.27-rc5-mm1 mystery trace
In-Reply-To: <20080904214115.2b4ab5fd.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0809051127230.25309@vixen.sonytel.be>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<1220586164.4879.116.camel@pasglop>
	<20080904204957.04a420ac.akpm@linux-foundation.org>
	<1220589401.4879.125.camel@pasglop>
	<20080904214115.2b4ab5fd.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1024440107-1220606856=:25309"
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

---584349381-1024440107-1220606856=:25309
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 4 Sep 2008, Andrew Morton wrote:
> On Fri, 05 Sep 2008 14:36:41 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Thu, 2008-09-04 at 20:49 -0700, Andrew Morton wrote:
> > > On Fri, 05 Sep 2008 13:42:44 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > > 
> > > > > g5:/usr/src/25> gdb vmlinux
> > > > > GNU gdb Red Hat Linux (6.3.0.0-1.21rh)
> > > > > Copyright 2004 Free Software Foundation, Inc.
> > > > > GDB is free software, covered by the GNU General Public License, and you are
> > > > > welcome to change it and/or distribute copies of it under certain conditions.
> > > > > Type "show copying" to see the conditions.
> > > > > There is absolutely no warranty for GDB.  Type "show warranty" for details.
> > > > > This GDB was configured as "ppc-yellowdog-linux-gnu"..."/usr/src/25/vmlinux": not in executable format: File format not recognized
> > > > > 
> > > > > probably there's some command line magic to make it work, but there
> > > > > shouldn't be.
> > > > 
> > > > Is this a 64 bits gdb ?
> > > 
> > > I don't think so - it's whatever ydl4.1 gave me.
> > > 
> > > A 64-bit binary on a 64-bit machine Should Just Work.  Maybe that's
> > > me being simplistic.
> > 
> > But is it a 64 bits binary ? 
> 
> vmlinux?  Yup.  According to file(1).

No, gdb.

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
---584349381-1024440107-1220606856=:25309--
