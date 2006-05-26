Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200605191211.18737.arnd@arndb.de>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<200605191211.18737.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:22:43 +1000
Message-Id: <1148624563.8089.96.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-19 at 12:11 +0200, Arnd Bergmann wrote:
> On Friday 19 May 2006 06:07, Benjamin Herrenschmidt wrote:
> >  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> > a "CELL" bit ? In which case should it cover the altivec additions too
> > or are those likely to exist in future non-Cell processors ?)
> 
> Isn't that already covered by PPC_FEATURE_CELL? Git log shows

Not specific to cell, 970 at least has it too.

Ben.
