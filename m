Return-Path: <dgibson@ozlabs.org>
Date: Mon, 11 Feb 2008 14:11:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080211031110.GD11572@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47AFB593.30805@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 10, 2008 at 09:40:19PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > This doesn't seem right.  warp_fixup_one_nor() changes only the
> > partition's offset, so you're not changing the size of any
> > partitions.  If you're not going to actually use any of the extra
> > flash space with 64M, I can't see why you'd bother moving around the
> > partitions you have.
> >   
> u-boot must be at the bottom of the flash. Also, for the 64M NOR flash 
> you can put everything in the NOR flash, I just don't show the 
> partitions. Booting from NOR is *much* faster than  booting from
> NAND.

Sorry, still not really following what's going on.  Without worrying
about the dts formatting or fixup code, can you summarise what the two
flash maps look like?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
