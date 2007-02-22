Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 33B6EDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 23:48:38 +1100 (EST)
Message-ID: <45DD911D.1090101@ru.mvista.com>
Date: Thu, 22 Feb 2007 15:48:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ebony.zhu@freescale.com
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
References: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
In-Reply-To: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

ebony.zhu@freescale.com wrote:

> Add the general support for Embedded Floating-Point instructions
> to fully comply with IEEE-754.

> Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S |    4 
>  arch/powerpc/kernel/traps.c          |   57 +++++
>  arch/powerpc/math-emu/Makefile       |   25 ++
>  arch/powerpc/math-emu/sfp-machine.h  |    2 
>  arch/powerpc/math-emu/spe.h          |    1 
>  arch/powerpc/sysdev/Makefile         |    1 
>  arch/powerpc/sysdev/sigfpe_handler.c |  361 ++++++++++++++++++++++++++++++++++

    I'm sorry, but is sysdev/ really fitting place for this file? Shouldn't it 
be under kernel/ or math-emu/ instead?

WBR, Sergei
