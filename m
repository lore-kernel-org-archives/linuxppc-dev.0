Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 6159867B52
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 11:11:06 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id l1so5280nzf
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:11:04 -0800 (PST)
Message-ID: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
Date: Wed, 13 Dec 2006 00:11:03 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: kgdb on mpc834x
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
patch for 2.6.14), but gdb client cannot connec to it. I turn on all
necessary kernel hacking options. Our board is customized with
MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
out? Following are the message from linux boot and gdb client.

## Booting image at ff300000 ...

loaded at:     FF300000 FFB71124
relocated to:  00800000 01071124
board data at: 007FFF70 007FFFF8
relocated to:  00805114 0080519C
zimage at:     00805915 00926A5E
initrd at:     00927000 0106E242
avail ram:     01072000 01472000

Linux/PPC load: mem=248M
Uncompressing Linux...done.
Now booting the kernel
mpc834x_sys_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem

(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Malformed response to offset query, timeout
