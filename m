Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2F49567B2D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 03:48:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Intercept System call using Kernel  module is 2.6 kernel
Date: Tue, 6 Jun 2006 19:48:56 +0200
References: <C26C730943E01145B4F89E37FE0A022002BBC7A2@itdsrvmail02.utep.edu>
	<C26C730943E01145B4F89E37FE0A022002BBC7A6@itdsrvmail02.utep.edu>
In-Reply-To: <C26C730943E01145B4F89E37FE0A022002BBC7A6@itdsrvmail02.utep.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606061948.56627.arnd@arndb.de>
Cc: "Meswani, Mitesh" <mmeswani@utep.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Tuesday 06 June 2006 18:25 schrieb Meswani, Mitesh:
> Any help and ideas are highly appreciated. =C2=A0

Tell your professor that the task you were given is=20

a) pointless, as you wouldn't use this kind of thing to
   solve an actual problem other than bad OS design
   homework.
b) not a correct approach regarding maintainability, since
   you can't tell for an arbitrary kernel version if
   the particular syscall you're abusing is now used for
   something else.

As a replacement task, choose one or more of the following:

=2D implement a syscall by _recompiling_ the kernel and call
  that from your user application.
=2D write a misc device driver that exposes a device to
  do ioctl() on.
=2D create a file in each of sysfs, procfs and debugfs to
  do your operation on, using read() and write().
=2D use a netlink socket for a two way communication with
  a kernel module.

	Arnd <><
