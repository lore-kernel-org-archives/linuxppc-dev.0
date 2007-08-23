Return-Path: <dgibson@ozlabs.org>
Date: Thu, 23 Aug 2007 13:37:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: How to port PReP to arch/powerpc?
Message-ID: <20070823033703.GK7042@localhost.localdomain>
References: <Pine.SOC.4.64.0708221444510.5639@math.ut.ee>
	<20070822072956.56b7df46@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070822072956.56b7df46@vader.jdub.homelinux.org>
Cc: Meelis Roos <mroos@linux.ee>, linuxppc-dev@ozlabs.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 07:29:56AM -0500, Josh Boyer wrote:
> On Wed, 22 Aug 2007 14:50:07 +0300 (EEST)
> Meelis Roos <mroos@linux.ee> wrote:
> 
> > It seems no one cares for arch/ppc any more but the move to powerpc was 
> > not finished completely (PReP subarch was not migrated but sees users, I 
> > do not know about the user base of the other subarches). So I have been 
> > thinking about migrating PReP support to arch/powerpc myself since I use 
> > it.
> 
> The merge is still on-going.  So it's not "finished" at all.
> 
> > Any general guidelines or specific hints about that? I have looked 
> > around in the code and some pieces are clearly PReP specific (setup, 
> > pci, boot) but others seem wuite a bit mixed up with other subarches.
> 
> David Gibson and Rob Landley had a quite interesting discussion about
> PReP last night on IRC.  You might want to contact them and see if they
> came to any conclusions.

Yes, my draft PReP support patch, tweaked this morning to build again
(changes roughly identical to Rob Landley's patch, I believe) is at:
	http://ozlabs.org/~dgibson/home/tmp/prep-support

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
