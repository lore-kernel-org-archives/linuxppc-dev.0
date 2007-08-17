Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05468DDE98
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 09:25:42 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a79f1cbe580d675c6bb231e4e3a0326b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
Date: Sat, 18 Aug 2007 01:25:34 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  include/asm-powerpc/8xx_immap.h   |  564 +++++++++++++++++
>  include/asm-powerpc/commproc.h    |  692 ++++++++++++++++++++
>  include/asm-powerpc/cpm2.h        | 1248 
> +++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/gg2.h         |   61 ++
>  include/asm-powerpc/highmem.h     |  135 ++++
>  include/asm-powerpc/hydra.h       |  102 +++
>  include/asm-powerpc/immap_cpm2.h  |  648 +++++++++++++++++++
>  include/asm-powerpc/kgdb.h        |   57 ++
>  include/asm-powerpc/m8260_pci.h   |  187 ++++++
>  include/asm-powerpc/mpc10x.h      |  180 ++++++
>  include/asm-powerpc/mpc52xx_psc.h |  191 ++++++

Can't we move most of this to the dir where they are used,
instead?


Segher
