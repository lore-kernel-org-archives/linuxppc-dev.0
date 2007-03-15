Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 4A903DDD08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 13:14:47 +1100 (EST)
Date: Wed, 14 Mar 2007 19:15:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070315021533.GB9777@mag.az.mvista.com>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314214805.GA9546@mag.az.mvista.com>
	<45F86DC1.9010804@freescale.com>
	<20070314232339.GA32287@mag.az.mvista.com>
	<20070315000445.GE12573@localhost.localdomain>
	<20070315015904.GB8406@mag.az.mvista.com>
	<20070315020234.GB14061@localhost.localdomain>
	<20070315020538.GC14061@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315020538.GC14061@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 01:05:38PM +1100, David Gibson wrote:
> On Thu, Mar 15, 2007 at 01:02:34PM +1100, David Gibson wrote:
> > Err... won't the initramfs image go in the same place as the initrd
> > image, not as part of the vmlinux.
> 
> Although, speaking of that.  Long term, I think it would be a good
> idea for the wrapper script to base the zImage's link address on the
> size of the vmlinux.

That's an interesing idea.  I'm sure there will be sizes that will bring
the load address into conflict with what the fw needs to do the actual
download though.  Nothing is ever easy, is it? :)

Mark
