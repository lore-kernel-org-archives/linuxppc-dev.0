Return-Path: <scottwood@freescale.com>
Message-ID: <49EE25D8.6040906@freescale.com>
Date: Tue, 21 Apr 2009 15:00:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: subrata@linux.vnet.ibm.com
Subject: Re: [BUILD FAILURE 10/12] Next April 21 : PPC64
	randconfig	[drivers/mtd/maps/sbc8240.o]
References: <1240340059.9110.143.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1240340059.9110.143.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: carolyn.j.smith@exgate.tek.com, sachinp <sachinp@linux.vnet.ibm.com>,
	Adrian Bunk <bunk@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subrata Modak wrote:
> This is a very old one. Doesn´t seem to go away. Reported this earlier
> on 14th April:
> http://lkml.org/lkml/2009/4/14/483,
> 
> CC [M]  drivers/mtd/maps/sbc8240.o
> drivers/mtd/maps/sbc8240.c:31:1: warning: "DEBUG" redefined
> In file included from drivers/mtd/maps/sbc8240.c:23:
> include/linux/mtd/mtd.h:339:1: warning: this is the location of the
> previous definition
> drivers/mtd/maps/sbc8240.c: In function ‘init_sbc8240_mtd’:
> drivers/mtd/maps/sbc8240.c:172: error: ‘sbc8240_mtd’ undeclared (first
> use in this function)
> drivers/mtd/maps/sbc8240.c:172: error: (Each undeclared identifier is
> reported only once
> drivers/mtd/maps/sbc8240.c:172: error: for each function it appears in.)
> drivers/mtd/maps/sbc8240.c: In function ‘cleanup_sbc8240_mtd’:
> drivers/mtd/maps/sbc8240.c:233: error: ‘sbc8240_mtd’ undeclared (first
> use in this function)

This looks like an arch/ppc orphan.  It's not enabled by any defconfig, 
and it doesn't look like it does anything that physmap_of can't do.

I'd just remove it.

-Scott
