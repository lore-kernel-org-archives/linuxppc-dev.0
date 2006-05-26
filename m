Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Pinski <pinskia@physics.uc.edu>
In-Reply-To: <11D4E003-85A4-48A0-9654-BEAE5600B89C@physics.uc.edu>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
	<11D4E003-85A4-48A0-9654-BEAE5600B89C@physics.uc.edu>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:19:53 +1000
Message-Id: <1148624394.8089.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I'm assuming you mean the instructions described under "AltiVec Memory
> > Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
> > dstst, dss and dssall?
> 
> They are nops on the Cell though.  They are also microcoded on the 970.

It's still useful to have a way to inform userland of their absence (or
inefficency).

> > If you're referring to the extended dcbt that includes streaming hints
> > (as documented in the 64-bit PEM, but not in PPC book2 2.02), then a
> > separate bit is likely needed -- obviously at least 970 seems to
> > implement them.
> 
> Yes they are implemented on the 970.
