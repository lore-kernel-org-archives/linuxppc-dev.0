Return-Path: <Sylvain.Lamontagne@novariant.com>
Received: from sm1.novariant.com (sm1.novariant.com [76.238.142.74])
	by ozlabs.org (Postfix) with ESMTP id 02E11DE222
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 08:17:51 +1000 (EST)
Subject: Installation on a MPC5200 based custom board
From: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 11 Jul 2008 18:07:54 -0400
Message-Id: <1215814074.9106.76.camel@NV10035>
Mime-Version: 1.0
Cc: Michel Lemieux <Michel.Lemieux@novariant.com>,
	Craig Cornwall <craig.cornwall@novariant.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greetings

We are currently trying to put a Kernel 2.6.26 on a custom board based
on the MPC5200 processor and the designed of the board was based on the
lite5200b evaluation board.

We would like to have some advice regarding the installation process for
this kernel. The hardware currently work (still buggy, but work) with a
kernel 2.6.23 compiled with ARCH ppc running on a U-Boot 1.1.6. For what
I understand now, the ARCH ppc if kind of deprecated and we have to
switch to ARCH powerpc. I'm new to the concept of device tree, do I have
to modify it myself or the file wild be generated automatically ?

Should it be better for us to upgrade our version of U-Boot to 1.3.* to
get the support of device tree? Currently we tried with the wrapper
trick of using cuImage.lite5200b and the v1.1.6 but it doesn't seem to
work.

Also, we would like to know if we have to recompile everything on the
board (U-Boot/Kernel/Busybox) since we switched ARCH from ppc to
powerpc?

We are also wondering what is the cross-compilation tools that you are
using? Or do you have any good advice on a choice? Currently we are
building with gcc-4.1.0-glibc-2.3.6 for ppc on an x86 host running
Ubuntu 8.04 or we also have a Fedora Core 7 laptop but, I have see a
kernel compilation warning regarding gcc 4.1 saying that it's known to
brake the kernel.

Should we upgrade everything (U-Boot/Kernel/Busybox) and recreate a new
Ramdisk ?

Anybody know a good development tools to use with a CodeWarrior USB TAP
from freescale ? The CodeWarrior IDE doesn't seems to work properly for
us.

This is a lot of questions and they maybe unclear since I'm new to all
this, but if you need any more information I can provide them.

Best Regards,

-- 
Sylvain Lamontagne
--------------------
Software Developer
Novariant Canada
Ext.: 4940
