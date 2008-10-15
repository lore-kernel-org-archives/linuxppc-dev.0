Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D53FFDDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 20:41:57 +1100 (EST)
Subject: Re: [git pull] Please pull from powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200810151041.29069.arnd@arndb.de>
References: <1224033396.8157.386.camel@pasglop>
	<20081015083516.GL23557@erda.amd.com>
	<200810151041.29069.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 20:41:26 +1100
Message-Id: <1224063686.8157.449.camel@pasglop>
Mime-Version: 1.0
Cc: Robert Richter <robert.richter@amd.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 10:41 +0200, Arnd Bergmann wrote:
> On Wednesday 15 October 2008, Robert Richter wrote:
> > there are still these OProfile patches for powerpc pending:
> > 
> > Carl Love (1):
> >       powerpc/cell/oprofile: fix mutex locking for spu-oprofile
> > 
> > Roel Kluin (1):
> >       powerpc/cell/oprofile: vma_map: fix test on overlay_tbl_offset
> > 
> > Can you or Paul send them upstream? You can pull from here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git powerpc-for-paul
> > 
> 
> The patch from Roel is already in there, with a slightly different
> subject line. The one from Carl is still missing.

I'll put it in my tree tomorrow, it will be in the second batch. For
lurkers, make sure that if you have a patch missing, it's resent and
shows up in patchwork. Some patches that missed the new patchwork
transition might have fallen off if paulus didn't pick them up before I
took over.

Cheers,
Ben.
