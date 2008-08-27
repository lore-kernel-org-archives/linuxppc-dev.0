Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id E9EA0DDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 02:18:33 +1000 (EST)
Date: Wed, 27 Aug 2008 18:18:32 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH 2/4] Add cpufreq driver for the IBM PowerPC 750GX
In-Reply-To: <20080827160859.GA2009@cynthia.pants.nu>
Message-ID: <Pine.LNX.4.64.0808271817300.22151@vixen.sonytel.be>
References: <48B28F23.1000906@hypersurf.com> <200808261329.22699.arnd@arndb.de>
	<48B51A31.8090909@hypersurf.com> <200808271334.16712.arnd@arndb.de>
	<Pine.LNX.4.64.0808271339230.22151@vixen.sonytel.be>
	<20080827160859.GA2009@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1437269649-1219853912=:22151"
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>,
	Arnd Bergmann <arnd@arndb.de>
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

---584349381-1437269649-1219853912=:22151
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 27 Aug 2008, Brad Boyer wrote:
> On Wed, Aug 27, 2008 at 01:40:10PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 27 Aug 2008, Arnd Bergmann wrote:
> > > On Wednesday 27 August 2008, Kevin Diggs wrote:
> > > > Arnd Bergmann wrote:
> > > > > Are there even SMP boards based on a 750? I thought only 74xx
> > > > > and 603/604 were SMP capable.
> > > > > 
> > > > Not that I have heard of. I thought it was lacking some hardware that
> > > > was needed to do SMP? Can the 603 do SMP?
> > > 
> > > No, I was wrong about the 603. The machine I was thinking of is actually
> > > 604e.
> > 
> > The BeBox had a dual 603.
> 
> I remember going to a talk by some of the Be engineers, and I think they
> said that the 603 had terrible SMP performance. My understanding was that
> Motorola recommended the 604 for SMP configurations but the 603 was much
> cheaper and mostly worked. The 750 is much more like the 603 than the 604.

Yes, the 603 was not designed for SMP boxes. But that didn't mean nobody had
the courage to (mis)use them that way ;-)

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
---584349381-1437269649-1219853912=:22151--
