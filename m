Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id 8B36E2C03CA
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 23:38:01 +1100 (EST)
Date: Wed, 6 Mar 2013 14:29:13 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Bisected 3.9-rc1 boot failure on G5
Message-ID: <20130306122913.GC14552@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Booting 3.9-rc1 fails with the following dump:

   Invalid memory access at %SSR0: 00000000.00000380 %SSR1: 90000000.00081000

According to bisect, it's caused by 1fbe9cf2598dae3bd464d860bd89c67b1ff8682b
(powerpc: Build kernel with -mcmodel=medium).

I'm loading & booting the kernel with GRUB 2.00 on iMac G5 (PowerMac8,1),
toolchain is GCC 4.7.2 / binutils 2.23.1.

A.
