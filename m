Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C20BADE1C5
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 00:09:44 +1000 (EST)
Message-Id: <8CB3566C-F433-4457-906D-247BBB8D5505@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 09:09:38 -0500
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 6:54 AM, Segher Boessenkool wrote:

>> GCC 4.4.x looks to be adding support for generating out-of-line  
>> register
>> saves/restores based on:
>>
>> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
>>
>> This breaks the bootwrapper as we'd need to link with libgcc to get  
>> the
>> implementation of the register save/restores.
>>
>> To workaround this issue, we just stole the save/restore code from  
>> gcc
>> and simplified it down for our needs (integer only).
>
> Why can't we link with libgcc, instead?

Do you have or can you generate a ppc64 toolchain with this patch in it?

- k
