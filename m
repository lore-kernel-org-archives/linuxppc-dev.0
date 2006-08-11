Return-Path: <nkbj@mail.tele.dk>
Received: from fep30.mail.dk (fep30.mail.dk [80.160.76.194])
	by ozlabs.org (Postfix) with ESMTP id 16CC767B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 16:14:02 +1000 (EST)
Received: from fep43.mail.dk ([195.41.46.226]) by fep30.mail.dk
	(InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
	id <20060811061400.IRXW11550.fep30.mail.dk@fep43.mail.dk>
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 08:14:00 +0200
Received: from [87.51.138.62] by fep43.mail.dk
	(InterMail vG.2.02.00.00 201-2161-120-101-20051020) with ESMTP
	id <20060811061359.RQSL15950.fep43.mail.dk@[87.51.138.62]>
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 08:13:59 +0200
Subject: latest git: compile error: arch/powerpc/kernel/built-in.o
From: Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 11 Aug 2006 08:13:55 +0200
Message-Id: <1155276835.4844.2.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>   LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
> (.text+0xcd34): undefined reference to `kexec_sr_activated'
> arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
> (.text+0xcd44): undefined reference to `crash_kexec_secondary'
> arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
> (.init.text+0x1cdc): undefined reference to `reserve_crashkernel'
> arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
> (.init.text+0x1e1c): undefined reference to `overlaps_crashkernel'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory `/home/shorty/kernel-factory/git.08102006/linux-2.6'
> make: *** [debian/stamp-build-kernel] Error 2

I've hit the same build error in 2.6.18-rc4. Maybe the patches should also be added to the main kernel tree?

Regards,
Niels Kristian
