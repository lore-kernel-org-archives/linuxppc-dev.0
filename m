Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DCA2DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:05:47 +1100 (EST)
Subject: Re: [PATCH] FIx compile of swim3 as module
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080212204802.18a7a868@zod.rchland.ibm.com>
References: <20080213024019.GX6887@bakeyournoodle.com>
	<20080212204802.18a7a868@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Feb 2008 17:03:52 +1100
Message-Id: <1202882632.7296.25.camel@pasglop>
Mime-Version: 1.0
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, kyle@mcmartin.ca,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-12 at 20:48 -0600, Josh Boyer wrote:
> > The current pmac32_defconfig fails to build with the following
> error:
> > 
> >   Building modules, stage 2.
> > ERROR: "check_media_bay" [drivers/block/swim3.ko] undefined!
> > WARNING: modpost: Found 23 section mismatch(es).
> > To see full details build your kernel with:
> > 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> > make[2]: *** [__modpost] Error 1
> > 
> > This patch fixes that.
> 
> Kyle posted a slightly different patch that seemed to still keep
> the original intention of ifdefery in tact.  I've no idea which is
> better, but the three of you might want to compare notes.

Just remove the bloody ifdef's, they are just a useless pain.

Ben.
