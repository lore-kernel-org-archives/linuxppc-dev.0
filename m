Return-Path: <olof@lixom.net>
Date: Fri, 19 May 2006 11:18:22 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Cell and new CPU feature bits
Message-ID: <20060519161822.GL8220@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<200605191211.18737.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200605191211.18737.arnd@arndb.de>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 12:11:18PM +0200, Arnd Bergmann wrote:
> On Friday 19 May 2006 06:07, Benjamin Herrenschmidt wrote:
> >  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> > a "CELL" bit ? In which case should it cover the altivec additions too
> > or are those likely to exist in future non-Cell processors ?)
> 
> Isn't that already covered by PPC_FEATURE_CELL? Git log shows

First, please don't use the cell bit for this since other processors
seem to implement the same things.

Second, the quoted information is 6 months old, and seemingly stale by
now. When Paulus pushed the POWER6 patch, he switched from the notion
of it signifying processor model to being base arch version. See:

http://ozlabs.org/pipermail/linuxppc-dev/2006-April/022525.html

(My patch to rename the existing POWER* bits to ARCH_2_* wasn't picked
up, I'll resend)


-Olof
