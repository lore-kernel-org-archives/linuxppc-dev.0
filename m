Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A81D9DE212
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:15:45 +1100 (EST)
Message-Id: <FAC79874-50F8-4C14-AE9B-A17BC51E8E87@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 13:15:20 -0600
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com><20080131161527.GT14201@localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>                }
> (gdb) list *0xc000f0a0
> No source file for address 0xc000f0a0.
> (gdb) disassemble 0xc000f0a0
> Dump of assembler code for function __flush_dcache_icache:
> 0xc000f08c <__flush_dcache_icache+0>:   dec    %esi
> 0xc000f08d <__flush_dcache_icache+1>:   addb   $0x20,(%eax)
> 0xc000f090 <__flush_dcache_icache+4>:   push   %esp
> 0xc000f091 <__flush_dcache_icache+5>:   arpl   %ax,(%eax)
> 0xc000f093 <__flush_dcache_icache+7>:   cmp    %al,%es: 
> 0x897c8000(%eax)
> 0xc000f09a <__flush_dcache_icache+14>:  add    0x781b667c(%esi),%esp
> 0xc000f0a0 <__flush_dcache_icache+20>:  jl     0xc000f0a2
> <__flush_dcache_icache+22>
> 0xc000f0a2 <__flush_dcache_icache+22>:  sbb    %ch,0x63(%eax,%edi,1)
> 0xc000f0a6 <__flush_dcache_icache+26>:  add    %ah,(%eax)
> 0xc000f0a8 <__flush_dcache_icache+28>:  inc    %edx
> 0xc000f0a9 <__flush_dcache_icache+29>:  add    %bh,%bh
> 0xc000f0ab <__flush_dcache_icache+31>:  clc
> 0xc000f0ac <__flush_dcache_icache+32>:  jl     0xc000f0ae
> <__flush_dcache_icache+34>
> 0xc000f0ae <__flush_dcache_icache+34>:  add    $0xac,%al
> 0xc000f0b0 <__flush_dcache_icache+36>:  jl     0xc000f03b
> <flush_dcache_range+15>
> 0xc000f0b2 <__flush_dcache_icache+38>:  add    0xac37007c(%esi),%esp
> 0xc000f0b8 <__flush_dcache_icache+44>:  cmp    %al,%dh
> 0xc000f0ba <__flush_dcache_icache+46>:  add    %ah,(%eax)
> 0xc000f0bc <__flush_dcache_icache+48>:  inc    %edx
> 0xc000f0bd <__flush_dcache_icache+49>:  add    %bh,%bh
> 0xc000f0bf <__flush_dcache_icache+51>:  clc
> 0xc000f0c0 <__flush_dcache_icache+52>:  jl     0xc000f0c2
> <__flush_dcache_icache+54>
> 0xc000f0c2 <__flush_dcache_icache+54>:  add    $0xac,%al
> 0xc000f0c4 <__flush_dcache_icache+56>:  dec    %esp
> 0xc000f0c5 <__flush_dcache_icache+57>:  add    %al,(%ecx)
> 0xc000f0c7 <__flush_dcache_icache+59>:  sub    $0x4e,%al
> 0xc000f0c9 <__flush_dcache_icache+61>:  addb   $0x20,(%eax)
> End of assembler dump.

This doesn't look like ppc disasm to me :)

- k
