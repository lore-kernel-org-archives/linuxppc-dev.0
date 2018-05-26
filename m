Return-Path: <pmenzel@molgen.mpg.de>
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t9Tn4MGGzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:42:53 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>
Subject: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
Message-ID: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
Date: Sat, 26 May 2018 06:35:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Linux folks,


Building the configuration created with `make tinyconfig` on the Power 8 
system IBM S822LC with Ubuntu 18.04 fails with the error below.

```
$ git describe --dirty
v4.17-rc6-296-gbc2dbc5420e8
$ git log --oneline -1
bc2dbc5420e8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 
'akpm' (patches from Andrew)
$ make tinyconfig
$ make -j120
[…]
   AS      arch/powerpc/kernel/head_32.o
arch/powerpc/kernel/head_32.S: Assembler messages:
arch/powerpc/kernel/head_32.S:1106: Error: missing operand
scripts/Makefile.build:413: recipe for target 
'arch/powerpc/kernel/head_32.o' failed
make[1]: *** [arch/powerpc/kernel/head_32.o] Error 1
[…]
```

Is this expected? *ppc64_defconfig* and *ppc64e_defconfig* build fine.


Kind regards,

Paul
