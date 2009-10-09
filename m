Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DA68B7B89
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 08:13:47 +1100 (EST)
Subject: Re: Linux net-2.6 build error for PPC
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091009174933.GA6797@linux-ox1b.qlogic.org>
Date: Fri, 9 Oct 2009 16:13:38 -0500
Message-Id: <6682E474-0BDC-4A84-9D98-D0D5158AE8C0@kernel.crashing.org>
References: <20091009174933.GA6797@linux-ox1b.qlogic.org>
To: Ron Mercer <ron.mercer@qlogic.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 9, 2009, at 12:49 PM, Ron Mercer wrote:

> I recently grabbed the latest net-2.6 kernel for a powerpc test box =20=

> and
> got this compile error.
>
>  CC      arch/powerpc/kernel/cputable.o
>    CC      arch/powerpc/kernel/ptrace.o
>      CC      arch/powerpc/kernel/syscalls.o
>        CC      arch/powerpc/kernel/irq.o
> 	   CC      arch/powerpc/kernel/align.o
> 	     CC      arch/powerpc/kernel/signal_32.o
> 	       CC      arch/powerpc/kernel/pmc.o
> 		  CC      arch/powerpc/kernel/vdso.o
> 		    cc1: warnings being treated as errors
> 		      arch/powerpc/kernel/vdso.c:78: warning: alignment =
of
> 		        =E2so_data_store=E2s greater than maximum object =
file
> 			   alignment.  Using 32768
> 			     make[1]: *** [arch/powerpc/kernel/vdso.o]
> 			     Error 1
> 			       make: *** [arch/powerpc/kernel] Error 2
> 				  [root@localhost linux-2.6-net.git]#
>
>
>
> 				    Any suggestions would be =
appreciated.

What config & what compiler?

- k=
