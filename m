Return-Path: <trini@kernel.crashing.org>
Date: Wed, 24 Aug 2005 13:13:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20050824201332.GD15735@smtp.west.cox.net>
References: <20050822141235.GA7110@austin.ibm.com>
	<E470B224-F0FB-48D7-9A04-E42247B11554@freescale.com>
	<20050824182020.GB15735@smtp.west.cox.net>
	<200508242203.27210.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200508242203.27210.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 24, 2005 at 10:03:26PM +0200, Arnd Bergmann wrote:
> On Middeweken 24 August 2005 20:20, Tom Rini wrote:
> > On Tue, Aug 23, 2005 at 12:05:36PM -0500, Kumar Gala wrote:
> > > 
> > > This seems reasonable then to have them in include/asm-powerpc.  I  
> > 
> > No it doesn't.  You can easily make the drivers get the includes from
> > <platforms/pmac/foo.h>, arch/$(ARCH) is already always in the search
> > path, I believe (if not, it's easy to add Makefile things to get it).
> 
> I don't think any architecture except ppc32 has traditionally had
> arch/$ARCH in its include path, and it would probably come as a surprise
> to many kernel developers if this were used more.

True, but it's possible that the pmac drivers could also be converted to
use something else to pass around infos, register IO and such so the
headers can still live in arch/powerpc/platforms/pmac/

-- 
Tom Rini
http://gate.crashing.org/~trini/
