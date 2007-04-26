Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id EA804DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 16:08:58 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 25 Apr 2007 23:08:55 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Message-ID: <20070426060855.GD2030@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260255.04490.arnd@arndb.de>
	<20070426011328.GR4046@mag.az.mvista.com>
	<200704260402.17248.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704260402.17248.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 02:02:16AM +0000, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Mark A. Greer wrote:
> > > location is the smaller part of the problem. Even if it was the right
> > > thing to scan the tree and then create platform_data instead of using
> > > the of_device, that code would still belong into the device driver.
> > 
> > I don't think of_device is going to work very well on MIPS.
> 
> Ok, I see your point there. But after looking at the i2c and net drivers,
> I believe that they can easily be split into an architecture dependent
> part that is either an of_platform_driver or a platform_driver, and
> a common part that does not know about either of these.

Oh, it's certainly possible, but it doesn't seem desirable to me. Why
should the drivers carry the burden of supporting both platform_driver
and of_platform_driver interfaces?

-Dale
