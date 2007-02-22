Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1AA8DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 05:23:40 +1100 (EST)
In-Reply-To: <45DDCB28.9050408@ru.mvista.com>
References: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
	<45DD911D.1090101@ru.mvista.com> <45DD9E1B.7060604@ru.mvista.com>
	<0d13db503c02906b8d61a65f295e3ddd@kernel.crashing.org>
	<45DDCB28.9050408@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF8088A8-D4D1-4C4E-A9A7-16944C048145@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 22 Feb 2007 12:22:39 -0600
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


On Feb 22, 2007, at 10:56 AM, Sergei Shtylyov wrote:

> Hello.
>
> Segher Boessenkool wrote:
>>>>>  arch/powerpc/sysdev/sigfpe_handler.c |  361
>>>>> ++++++++++++++++++++++++++++++++++
>
>>>>    I'm sorry, but is sysdev/ really fitting place for this file?
>>>> Shouldn't it be under kernel/ or math-emu/ instead?
>
>>>     Also, the name doesn't look fittingto me, since we're not  
>>> handling
>>> *SIGFPE* here (which is for userland), we're handling SPE  
>>> exceptions.
>
>> arch/powerpc/math-emu/spe/<whatever>.c seems like a good
>> place?
>
>     Yeah, certainly more like it. :-)
>
>> Segher

Agreed, this shouldn't have been in sysdev, didn't notice that :)

We should probably rename this as well, since its not just handling  
the sigfpe part, but the actual fixup/emulation.

- k
