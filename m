Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp11.wanadoo.fr (smtp11.wanadoo.fr [193.252.22.31])
	by ozlabs.org (Postfix) with ESMTP id B269167A70
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 17:45:30 +1100 (EST)
Date: Fri, 25 Feb 2005 07:36:09 +0100
To: Christian Kujau <evil@g-house.de>
Message-ID: <20050225063609.GA21244@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <421E7033.1030600@g-house.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
	PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 25, 2005 at 01:24:19AM +0100, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sven Luther wrote:
> > 
> > Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> > meanwhile, you can try : 
> > 
> >   http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd
> 
> oh, what fun - it's booting! de4x5 is loading (although i build my kernels
> with a (compiled in) tulip driver). sym53c8xx gets loaded and initializing
> the scsi bus is *not* blocking all other activities as usual.
> 
> here are the logs:
> 
> http://nerdbynature.de/bits/hal/d-i-2005.02.23/  (working 2.6.8 from Sven)
> http://nerdbynature.de/bits/hal/2.6.11-rc3/      (scsi errors)
> 
> (note: i still have no disks attached)

So, now, we need to find out what the problems where, i think it is something
that went in between 2.6.8 and 2.6.10, and leigh said he had some ideas. Leigh
can you elaborate on those ? 

Friendly,

Sven Luther
