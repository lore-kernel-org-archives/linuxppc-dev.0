Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 8E516DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 11:11:26 +1000 (EST)
Date: Wed, 25 Apr 2007 18:13:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070426011328.GR4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260221.20150.arnd@arndb.de>
	<20070426004302.GP4046@mag.az.mvista.com>
	<200704260255.04490.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200704260255.04490.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 02:55:03AM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > of_find_compatible_node() is not being called from a driver, its being
> > called from platform code.  Its extracting info from the device tree and
> > setting up the platform_data required by the driver.
> 
> Well, the idea of putting the device driver code into a platform specific

It isn't device driver code.  It providing the driver with some info
that it needs but doesn't have the ability to get, in general.

> location is the smaller part of the problem. Even if it was the right
> thing to scan the tree and then create platform_data instead of using
> the of_device, that code would still belong into the device driver.

I don't think of_device is going to work very well on MIPS.

Mark
