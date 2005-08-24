Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id B82C768113
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 06:14:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Wed, 24 Aug 2005 22:03:26 +0200
References: <20050822141235.GA7110@austin.ibm.com>
	<E470B224-F0FB-48D7-9A04-E42247B11554@freescale.com>
	<20050824182020.GB15735@smtp.west.cox.net>
In-Reply-To: <20050824182020.GB15735@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508242203.27210.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Tom Rini <trini@kernel.crashing.org>,
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

On Middeweken 24 August 2005 20:20, Tom Rini wrote:
> On Tue, Aug 23, 2005 at 12:05:36PM -0500, Kumar Gala wrote:
> > 
> > This seems reasonable then to have them in include/asm-powerpc.  I  
> 
> No it doesn't.  You can easily make the drivers get the includes from
> <platforms/pmac/foo.h>, arch/$(ARCH) is already always in the search
> path, I believe (if not, it's easy to add Makefile things to get it).

I don't think any architecture except ppc32 has traditionally had
arch/$ARCH in its include path, and it would probably come as a surprise
to many kernel developers if this were used more.

Currently, there seem to be hardly any users of this "feature" in ppc32
that can't be trivially converted to including local files, so I'd 
rather not see this moved over to arch/powerpc.

	Arnd <><
