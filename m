Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CE05DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 02:45:40 +1000 (EST)
Date: Wed, 1 Aug 2007 09:44:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rishikesh K Rajak <risrajak@in.ibm.com>
Subject: Re: build error on powerpc for 2.6.23-rc1-mm2
Message-Id: <20070801094442.b710279b.akpm@linux-foundation.org>
In-Reply-To: <OFFC0F3DEC.2DEDE1A8-ON6525732A.002DB5E7-6525732A.002DEF2C@in.ibm.com>
References: <OFFC0F3DEC.2DEDE1A8-ON6525732A.002DB5E7-6525732A.002DEF2C@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007 13:52:05 +0530 Rishikesh K Rajak <risrajak@in.ibm.com> wrote:

> 
> Hi Andrew,
> 
> I am getting following error on powerpc almost for allyesconfig,
> allmodconfig.
> 
> Error produced:
> 
> PowerPC: allmodconfig,allyesconfig
> 
>   CC      arch/powerpc/mm/tlb_64.o
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/copyuser_64.S:
>  Assembler messages:
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/copyuser_64.S:27:
>  Error: Unrecognized opcode: `mtocrf'
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/copyuser_64.S:138:
>  Error: Unrecognized opcode: `mtocrf'
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/copyuser_64.S:153:
>  Error: Unrecognized opcode: `mtocrf'
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/memcpy_64.S:
>  Assembler messages:
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/memcpy_64.S:15:
>  Error: Unrecognized opcode: `mtocrf'
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/memcpy_64.S:131:
>  Error: Unrecognized opcode: `mtocrf'
> /home/risrajak/TEST2/TEST/linux/CurrentTest/23-rc1-mm2-testing/linux-2.6.23-rc1/arch/powerpc/lib/memcpy_64.S:146:
>  Error: Unrecognized opcode: `mtocrf'
> make[2]: *** [arch/powerpc/lib/memcpy_64.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>   CC      arch/powerpc/sysdev/mpic_u3msi.o
> make[2]: *** [arch/powerpc/lib/copyuser_64.o] Error 1
> make[1]: *** [arch/powerpc/lib] Error 2
> 

Presumably, disabling CONFIG_POWER4_ONLY would fix that.

It could be that your toolchain is insufficiently recent.  Which
version of binutils are you using?
