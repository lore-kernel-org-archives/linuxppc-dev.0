Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C20667AC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 12:11:19 +1000 (EST)
Date: Fri, 22 Apr 2005 04:11:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marco Schramel <Schramel.Linux@go.bartec.de>,
	PPC_LINUX <linuxppc-embedded@ozlabs.org>
Message-ID: <20050422021117.GC27755@wohnheim.fh-wedel.de>
References: <20050421103234.ED367C1510@atlas.denx.de>
	<200504211502.48761.Schramel.Linux@go.bartec.de>
	<20050422013134.GB27755@wohnheim.fh-wedel.de>
	<20050422015337.GC20046@gate.ebshome.net>
	<20050422015552.GD20046@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050422015552.GD20046@gate.ebshome.net>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 21 April 2005 18:55:52 -0700, Eugene Surovegin wrote:
> On Thu, Apr 21, 2005 at 06:53:37PM -0700, Eugene Surovegin wrote:
> > On Fri, Apr 22, 2005 at 03:31:34AM +0200, J?rn Engel wrote:
> > 
> > [snip]
> > 
> > > 1. Erase the flash partition.  Either
> > >    o eraseall /dev/mtdX or
> > >    o cat file_filled_with_0xff > /dev/mtdblockX
> > 
> > Huh? I fail to see how options you listed are equivalent. By 
> > "cat"ing file filled with 0xff you cannot erase flash, period.
> > 
> > Only eraseall (or erase, if partition occupies 1 erase block) flash 
> > can be erased.
> 
> Oops, sorry, I failed to notice /dev/mtdblockX. Stupid me. Ignore this 
> noise.

Btw, I've also written a tool called 'ff' once.  It will simply write
tons of 0xff to stdout.  Rewriting the thing from scratch should be
slightly faster than me trying to look for the source (about 4 lines
of code?).

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
