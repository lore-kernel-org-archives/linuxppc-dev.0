Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhNrg37g1zDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 14:38:59 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: syscall statx not implemented on powerpc
Date: Mon, 13 Mar 2017 03:33:07 +0000
Message-ID: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,=0A=
=0A=
I've just attempted to build a powerpc kernel from 4.11-rc2 using a =0A=
custom defconfig (available on request) and I'm hitting the following =0A=
error in the early stages of compilation.=0A=
=0A=
<stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=3Dcp=
p]=0A=
=0A=
Same thing seems to happen with mpc85xx_basic_defconfig.=0A=
=0A=
I don't actually need this syscall so I'd be happy to turn something off =
=0A=
to get things building. I did a quick search and couldn't see anything =0A=
on linuxppc-dev but google keeps correcting "statx" to "stats" so I =0A=
could have missed it.=0A=
=0A=
