Return-Path: <dgibson@ozlabs.org>
Date: Tue, 5 Jun 2007 10:43:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 2/3] powerpc: When appropriate,
	wrap device tree with zImage
Message-ID: <20070605004330.GC26483@localhost.localdomain>
References: <20070531195136.GA3699@mag.az.mvista.com>
	<20070531195535.GB3818@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070531195535.GB3818@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 31, 2007 at 12:55:35PM -0700, Mark A. Greer wrote:
> 
> There are 2 config options that indicate whether the platform being built
> has a device tree source file associated with it.  Namely,
> CONFIG_WANT_DEVICE_TREE and CONFIG_DEVICE_TREE.  When CONFIG_WANT_DEVICE_TREE
> is 'y' and CONFIG_DEVICE_TREE isn't an empty string, automatically wrap
> the specified device tree with the zImage being built.
> 
> To achieve this, the 'dts' variable will only be set when the conditions
> above are true.  The changes to the zImage.initrd.% and zImage.% rules
> cause the device tree to be wrapped when 'dts' is set; otherwise, they
> will work as they previosly did (i.e., build a zImage with no device tree).
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
