Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Feb 2008 11:48:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212004858.GG18348@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
	<20080212002030.GE18348@localhost.localdomain>
	<47B0EB23.9040101@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B0EB23.9040101@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 07:41:07PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > Err.. now I'm doubly confused.  Initially I thought you'd need to
> > change the size part of reg somewhere, but your description above just
> > convinced me you didn't (because you were essentially just shifting a
> > 4M map up into the high rather than low 4M of the 64M space).  Now
> > you're saying you do..
> >   
> If you tell the mtd driver that the flash is 64M, when it is really 4M, 
> it goes oops. So you do have to get the size right in the reg field.

Ah!  The top-level reg field, not the partitions.  Now I understand.

Except, since the 4M layout is the expected future norm, I would have
thought that's what you'd encode into the dts, and mangle it into the
64M version, rather than the other way around.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
