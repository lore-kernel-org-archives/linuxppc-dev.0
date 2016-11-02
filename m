Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x230.google.com (mail-yb0-x230.google.com
 [IPv6:2607:f8b0:4002:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t84c56HhqzDrJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 21:49:41 +1100 (AEDT)
Received: by mail-yb0-x230.google.com with SMTP id o7so3547176ybb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 03:49:41 -0700 (PDT)
MIME-Version: 1.0
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Wed, 2 Nov 2016 13:49:39 +0300
Message-ID: <CAOJe8K3eA38JfBDSsT0MHqm9az0awp_veU4=+_KKkPww=wtutg@mail.gmail.com>
Subject: compiling master.
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

compiling ppc head with bunch of asm errors on power8 box (gcc version 4.8.3 )
checked commit log but found nothing special. Looks like it's asm issue?
Has anybody seen that?

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:421: Error: operand out of range
(0xffffffffffff8680 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:663: Error: operand out of range
(0xffffffffffff8b00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:671: Error: operand out of range
(0xffffffffffff8c80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:708: Error: operand out of range
(0xffffffffffff8e00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:721: Error: operand out of range
(0xffffffffffff8e00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:137: Error: operand out of range
(0xffffffffffff8000 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:471: Error: operand out of range
(0xffffffffffff8700 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:517: Error: operand out of range
(0xffffffffffff8a00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:548: Error: operand out of range
(0xffffffffffff8880 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:580: Error: operand out of range
(0xffffffffffff8a00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:703: Error: operand out of range
(0xffffffffffff8e00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:728: Error: operand out of range
(0xffffffffffff8f80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:748: Error: operand out of range
(0xffffffffffff9100 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:760: Error: operand out of range
(0xffffffffffff9280 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:793: Error: operand out of range
(0xffffffffffff9480 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:799: Error: operand out of range
(0xffffffffffff9600 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:805: Error: operand out of range
(0xffffffffffff9780 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:815: Error: operand out of range
(0xffffffffffff9900 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:911: Error: operand out of range
(0xffffffffffff9a80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1130: Error: operand out of range
(0xffffffffffffad80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1152: Error: operand out of range
(0xffffffffffffaf00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1243: Error: operand out of range
(0xffffffffffffb080 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:149: Error: operand out of range
(0xffffffffffff8000 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:229: Error: operand out of range
(0xffffffffffff8380 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:241: Error: operand out of range
(0xffffffffffff8680 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:264: Error: operand out of range
(0xffffffffffff8180 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:916: Error: operand out of range
(0xffffffffffff9c00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:932: Error: operand out of range
(0xffffffffffff9d80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:938: Error: operand out of range
(0xffffffffffff9f00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:950: Error: operand out of range
(0xffffffffffffa080 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1005: Error: operand out of range
(0xffffffffffffa200 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1015: Error: operand out of range
(0xffffffffffffa380 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1025: Error: operand out of range
(0xffffffffffffa500 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1031: Error: operand out of range
(0xffffffffffffa680 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1068: Error: operand out of range
(0xffffffffffffa880 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1104: Error: operand out of range
(0xffffffffffffaa80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1110: Error: operand out of range
(0xffffffffffffac00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:472: Error: operand out of range
(0xffffffffffff8700 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:540: Error: operand out of range
(0xffffffffffff8a00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:549: Error: operand out of range
(0xffffffffffff8880 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:598: Error: operand out of range
(0xffffffffffff8a00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:719: Error: operand out of range
(0xffffffffffff8e00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
(0xffffffffffff8f80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:749: Error: operand out of range
(0xffffffffffff9100 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:761: Error: operand out of range
(0xffffffffffff9280 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:794: Error: operand out of range
(0xffffffffffff9480 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:800: Error: operand out of range
(0xffffffffffff9600 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:806: Error: operand out of range
(0xffffffffffff9780 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:816: Error: operand out of range
(0xffffffffffff9900 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:912: Error: operand out of range
(0xffffffffffff9a80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1131: Error: operand out of range
(0xffffffffffffad80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1244: Error: operand out of range
(0xffffffffffffb080 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:939: Error: operand out of range
(0xffffffffffff9f00 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1006: Error: operand out of range
(0xffffffffffffa200 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1016: Error: operand out of range
(0xffffffffffffa380 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1026: Error: operand out of range
(0xffffffffffffa500 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1032: Error: operand out of range
(0xffffffffffffa680 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1069: Error: operand out of range
(0xffffffffffffa880 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1105: Error: operand out of range
(0xffffffffffffaa80 is not between 0x0000000000000000 and
0x000000000000ffff)
arch/powerpc/kernel/exceptions-64s.S:1111: Error: operand out of range
(0xffffffffffffac00 is not between 0x0000000000000000 and
0x000000000000ffff)
