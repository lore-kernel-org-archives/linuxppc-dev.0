Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Apr 2007 10:45:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 0/13] powerpc: Add support for Marvell/mv64x60 and
	prpmc2800
Message-ID: <20070426004514.GC2193@localhost.localdomain>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 04:46:30PM -0700, Mark A. Greer wrote:
> The following set of patches add support for the Motorola prpmc2800/f101e platform.
> To support that platform, several other patches are required that can be grouped as
> follows:
> 
> 	- 1 patch to add Makefile rules that automatically compile & wrap a dts into
> 	  a zImage
> 	- 1 patch to add a new interface to the dt_xlate code.
> 	- 3 mv64x60 bootwrapper patches
> 	- 5 mv64x60 kernel patches
> 	- 3 prpmc2800 patches

Hrm.  This series adds an awful lot of code to the bootwrapper.  Is
there really no reasonable way to trim it, perhaps moving some of the
initialization to the kernel driver proper?  I can see that memory
controller setup and serial might need to be in the wrapper, but PCI
and I2C initialization?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
