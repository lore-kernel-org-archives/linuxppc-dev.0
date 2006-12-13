Return-Path: <hollis@penguinppc.org>
Received: from pop-tawny.atl.sa.earthlink.net (pop-tawny.atl.sa.earthlink.net
	[207.69.195.67]) by ozlabs.org (Postfix) with ESMTP id A0941679FD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 15:01:05 +1100 (EST)
Subject: Re: kgdb on mpc834x
From: Hollis Blanchard <hollis@penguinppc.org>
To: Reeve Yang <yang.reeve@gmail.com>
In-Reply-To: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 22:00:56 -0600
Message-Id: <1165982456.10549.1.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-13 at 00:11 +0000, Reeve Yang wrote:
> I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
> patch for 2.6.14), but gdb client cannot connec to it. I turn on all
> necessary kernel hacking options. Our board is customized with
> MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
> out? Following are the message from linux boot and gdb client.
> 
> ## Booting image at ff300000 ...
> 
> loaded at:     FF300000 FFB71124
> relocated to:  00800000 01071124
> board data at: 007FFF70 007FFFF8
> relocated to:  00805114 0080519C
> zimage at:     00805915 00926A5E
> initrd at:     00927000 0106E242
> avail ram:     01072000 01472000
> 
> Linux/PPC load: mem=248M
> Uncompressing Linux...done.
> Now booting the kernel
> mpc834x_sys_init(): exit
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> setup_arch: enter
> setup_arch: bootmem
> 
> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Ignoring packet error, continuing...
> Malformed response to offset query, timeout

Try 'set debug serial 1' in GDB; it will show you the actual data GDB is
receiving.

-Hollis
