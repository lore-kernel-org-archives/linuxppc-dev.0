Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40tSZX6SHXzF1gB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 May 2018 02:03:00 +1000 (AEST)
Subject: Re: arch/powerpc/kernel/head_32.S:1106: Error: missing operand
To: Paul Menzel <pmenzel+linuxppc-dev@molgen.mpg.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <ba9e3312-1923-dcc5-b07e-20f491881328@c-s.fr>
Date: Sat, 26 May 2018 18:02:51 +0200
MIME-Version: 1.0
In-Reply-To: <e015d6b2-79b8-e05d-5053-5ca0036679d3@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/05/2018 à 06:35, Paul Menzel a écrit :
> Dear Linux folks,
> 
> 
> Building the configuration created with `make tinyconfig` on the Power 8 
> system IBM S822LC with Ubuntu 18.04 fails with the error below.
> 
> ```
> $ git describe --dirty
> v4.17-rc6-296-gbc2dbc5420e8
> $ git log --oneline -1
> bc2dbc5420e8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 
> 'akpm' (patches from Andrew)
> $ make tinyconfig
> $ make -j120
> […]
>    AS      arch/powerpc/kernel/head_32.o
> arch/powerpc/kernel/head_32.S: Assembler messages:
> arch/powerpc/kernel/head_32.S:1106: Error: missing operand

There was a similar problem in 2015, see 
http://linux-kernel.2935.n7.nabble.com/Missing-operand-for-tlbie-instruction-on-Power7-td1206917.html

Which version of binutils do you use ?

Christophe

> scripts/Makefile.build:413: recipe for target 
> 'arch/powerpc/kernel/head_32.o' failed
> make[1]: *** [arch/powerpc/kernel/head_32.o] Error 1
> […]
> ```
> 
> Is this expected? *ppc64_defconfig* and *ppc64e_defconfig* build fine.
> 
> 
> Kind regards,
> 
> Paul

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
