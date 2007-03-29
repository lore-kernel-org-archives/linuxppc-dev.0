Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE962DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 09:12:56 +1000 (EST)
Date: Thu, 29 Mar 2007 17:12:30 -0600 (CST)
Message-Id: <200703292312.l2TNCU3B005014@sullivan.realtime.net>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
To: David Gibson <david@gibson.dropbear.id.au>
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
In-Reply-To: <20070315020234.GB14061@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu Mar 15 13:02:34 EST 2007 David Gibson wrote:
> On Wed, Mar 14, 2007 at 06:59:04PM -0700, Mark A. Greer wrote:
> 
> > This seems like a problem to me.  Premably, INITRAMFS will be used
> > more & more often so this check is going to fail more & more often.
> > We'll end up havng to keep moving the addr it loads at further & further
> > back or define platform_ops.vmlinux_alloc() and have the issue I
> > mentioned.
> 
> Err... won't the initramfs image go in the same place as the initrd
> image, not as part of the vmlinux.

That depends on if you use CONFIG_BLK_DEV_INITRD or CONFIG_INITRAMFS_SOURCE
(or both).

The later puts the cpio in the .init.ramfs section of the kernel.

milton
