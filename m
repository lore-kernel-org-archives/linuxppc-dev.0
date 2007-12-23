Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Sun, 23 Dec 2007 15:06:20 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [Cbe-oss-dev] Time for cell code reshuffle?
In-Reply-To: <20071223123501.GA19823@lst.de>
Message-ID: <Pine.LNX.4.62.0712231506050.17187@chinchilla.sonytel.be>
References: <200712211522.03841.arnd@arndb.de>
	<200712231247.44154.jk@ozlabs.org> <20071223123501.GA19823@lst.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584336837-362243690-1198418780=:17187"
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>, cbe-oss-dev@ozlabs.org
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

---584336837-362243690-1198418780=:17187
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 23 Dec 2007, Christoph Hellwig wrote:
> On Sun, Dec 23, 2007 at 12:47:42PM +0900, Jeremy Kerr wrote:
> > > To the question, where what it should go, I'd leave the decision to
> > > Jeremy, but my current idea would be:
> > >
> > > arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs
> > 
> > I'd suggest arch/powerpc/sysdev/spufs to keep arch/powerpc clean.
> > 
> > However, this may also depend on the (intended) structure of SPURSEngine 
> > support, which may mean that fs/spufs might be a better place. It would 
> > suck to have to move things twice, so maybe someone from Tosihba could 
> > provide some input? Would the powerpc spufs code be suitable for 
> > SPURSEngine?
> 
> Strong NACK for fs/spufs/  fs code is the smallest part of the spu
> support, and all this nasty lowlevel code doesn't belong into fs/ at
> all.

drivers/spu/?

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
---584336837-362243690-1198418780=:17187--
