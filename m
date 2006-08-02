Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A35367B5E
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 18:58:05 +1000 (EST)
Received: from box.varisys.co.uk ([81.187.198.46] helo=[192.168.3.251])
	by mail.humboldt.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50) id 1G8C2u-0003nI-PT
	for linuxppc-dev@ozlabs.org; Wed, 02 Aug 2006 09:25:41 +0100
Subject: SMP in 32-bit arch/powerpc
From: Adrian Cox <adrian@humboldt.co.uk>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 09:25:45 +0100
Message-Id: <1154507145.24203.0.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is anybody else having problems with 32-bit SMP support in arch/powerpc?
I'm using 2.6.17 as my current base, because I've not yet merged the
latest mpic changes.

I'm currently bringing up a dual-7448 board, and when I build the kernel
with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
strange thing is, this still happens when I don't start the second CPU.
Kernels built without CONFIG_SMP run flawlessly on the same hardware.

-- 
Adrian Cox <adrian@humboldt.co.uk>
