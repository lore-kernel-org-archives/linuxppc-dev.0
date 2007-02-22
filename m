Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8AF5DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 03:36:56 +1100 (EST)
In-Reply-To: <45DD9E1B.7060604@ru.mvista.com>
References: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
	<45DD911D.1090101@ru.mvista.com> <45DD9E1B.7060604@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0d13db503c02906b8d61a65f295e3ddd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 22 Feb 2007 17:36:48 +0100
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>  arch/powerpc/sysdev/sigfpe_handler.c |  361
>>> ++++++++++++++++++++++++++++++++++
>
>>    I'm sorry, but is sysdev/ really fitting place for this file?
>> Shouldn't it be under kernel/ or math-emu/ instead?
>
>     Also, the name doesn't look fittingto me, since we're not handling
> *SIGFPE* here (which is for userland), we're handling SPE exceptions.

arch/powerpc/math-emu/spe/<whatever>.c seems like a good
place?


Segher
