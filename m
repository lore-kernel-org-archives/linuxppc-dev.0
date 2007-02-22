Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D92A3DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 03:56:18 +1100 (EST)
Message-ID: <45DDCB28.9050408@ru.mvista.com>
Date: Thu, 22 Feb 2007 19:56:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
References: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
	<45DD911D.1090101@ru.mvista.com> <45DD9E1B.7060604@ru.mvista.com>
	<0d13db503c02906b8d61a65f295e3ddd@kernel.crashing.org>
In-Reply-To: <0d13db503c02906b8d61a65f295e3ddd@kernel.crashing.org>
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

Segher Boessenkool wrote:
>>>>  arch/powerpc/sysdev/sigfpe_handler.c |  361
>>>> ++++++++++++++++++++++++++++++++++

>>>    I'm sorry, but is sysdev/ really fitting place for this file?
>>> Shouldn't it be under kernel/ or math-emu/ instead?

>>     Also, the name doesn't look fittingto me, since we're not handling
>> *SIGFPE* here (which is for userland), we're handling SPE exceptions.

> arch/powerpc/math-emu/spe/<whatever>.c seems like a good
> place?

    Yeah, certainly more like it. :-)

> Segher

WBR, Sergei
