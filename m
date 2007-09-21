Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Sep 2007 11:00:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Cleanups for physmap_of.c (v2)
Message-ID: <20070921010055.GB4124@localhost.localdomain>
References: <20070920012225.GG14404@localhost.localdomain>
	<93451aaa11582c2db3be55961514cce9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93451aaa11582c2db3be55961514cce9@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@redhat.com>, Vitaly Wool <vwool@ru.mvista.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 07:11:59PM +0200, Segher Boessenkool wrote:
> > 	- (the big one) Despite the name, this driver really has
> > nothing to do with drivers/mtd/physmap.c.  The fact that the flash
> > chips must be physically direct mapped is a constrant, but doesn't
> > really say anything about the actual purpose of this driver, which is
> > to instantiate MTD devices based on information from the device tree.
> > Therefore the physmap name is replaced everywhere within the file with
> > "of_flash".
> 
> Do you think this code will handle NAND flash later, too?  If not,
> maybe "of_norflash" is better?

Uh.. maybe?  I guess we can either extend it or rename it in the
future sometime.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
