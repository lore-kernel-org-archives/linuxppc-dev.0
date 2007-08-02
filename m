Return-Path: <dgibson@ozlabs.org>
Date: Thu, 2 Aug 2007 10:14:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070802001418.GA29550@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com> <200708020135.03477.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200708020135.03477.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 01:35:03AM +0200, Arnd Bergmann wrote:
> On Wednesday 25 July 2007, Jon Loeliger wrote:
> > I'd like to make an official DTC Version 1.0.0 release soon!
> > To that end, I've published a repo on jdl.com with a v1.0.0-rc1
> > tag on it.  I anticipate some updates to the Documentation before
> > a final 1.0.0 release still.  However, if you have something
> > you would like to have be in The Real 1.0.0 release, please
> > let me know soon!
> 
> A  bug has been reported in both fedora and debian about /usr/bin/ftdump
> conflicting with a file of the same name in freetype.
> 
> Can we rename the binary in dtc to avoid this? Maybe /usr/bin/dtc-ftdump
> would be better.

Better yet, just omit it, since it's really not very useful.  That
should be happening now that my "improved make install target" patch
has been merged.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
