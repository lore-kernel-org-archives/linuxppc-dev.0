Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhpdx5tXSzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:01:09 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Paul Mackerras <paulus@samba.org>
Subject: Re: syscall statx not implemented on powerpc
Date: Mon, 13 Mar 2017 20:01:04 +0000
Message-ID: <6226603a58ba485391854ba231193741@svr-chch-ex1.atlnz.lc>
References: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
 <4396749.JbYdqAFZXV@localhost.localdomain>
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

On 13/03/17 21:52, Chandan Rajendra wrote:=0A=
> On Monday, March 13, 2017 03:33:07 AM Chris Packham wrote:=0A=
>> Hi,=0A=
>>=0A=
>> I've just attempted to build a powerpc kernel from 4.11-rc2 using a=0A=
>> custom defconfig (available on request) and I'm hitting the following=0A=
>> error in the early stages of compilation.=0A=
>>=0A=
>> <stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=
=3Dcpp]=0A=
>>=0A=
>> Same thing seems to happen with mpc85xx_basic_defconfig.=0A=
>>=0A=
>> I don't actually need this syscall so I'd be happy to turn something off=
=0A=
>> to get things building. I did a quick search and couldn't see anything=
=0A=
>> on linuxppc-dev but google keeps correcting "statx" to "stats" so I=0A=
>> could have missed it.=0A=
>>=0A=
>=0A=
> The upstream commit=0A=
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Da528d35e8bfcc521d7cb70aaf03e1bd296c8493f)=0A=
> that introduces the statx syscall provides a test program. I will wire-up=
 the=0A=
> syscall on ppc64, run that test program and post the patch if the test pr=
ogram=0A=
> works well.=0A=
>=0A=
=0A=
Thanks, I'd be happy to test a patch here.=0A=
=0A=
In the meantime I worked around the build issue by adding __INGORE_statx =
=0A=
to checksyscalls.sh.=0A=
=0A=
