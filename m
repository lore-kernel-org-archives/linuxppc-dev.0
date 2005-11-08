Return-Path: <sr@denx.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id AB66F686AD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 04:38:15 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 8 Nov 2005 18:38:11 +0100
References: <20051107124917.C1671@cox.net>
	<20051107190128.68d41294.akpm@osdl.org>
	<20051108093759.A26086@cox.net>
In-Reply-To: <20051108093759.A26086@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511081838.11236.sr@denx.de>
Cc: linuxppc64-dev@ozlabs.org
Subject: 440EP FPU support missing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the current linux version, Bamboo (440EP) won't compile anymore, because of 
missing fpu support:

make uImage
...
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/ppc/kernel/head_44x.o(.text+0x868): In function `_start':
: undefined reference to `KernelFP'
make: *** [.tmp_vmlinux1] Error 1

Somehow arch/ppc/kernel/fpu.S has disappeared. :-( I assume, this happened in 
the ppc/ppc64 -> powerpc merge. Any thoughts, why this file disappeared and 
how to solve this problem (just restore the original file)?

Best regards,
Stefan
