Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA0FCDDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:05:07 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5C9B@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890B768A2@zch01exm26.fsl.freescale.net>
	<24BADA7A-1716-43B1-BC92-F4DB7ED0D331@kernel.crashing.org>
	<F2C6FCFC-78EF-4660-85F8-10C1AFE860F4@kernel.crashing.org>
	<989B956029373F45A0B8AF0297081890019B5C9B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3C5278B-A57E-46EC-91FA-FB403817AFBF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_lib: export symbols to fix compile error when QE
	drivers compile as modules
Date: Fri, 19 Oct 2007 08:05:44 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>> Export symbols of qe_lib to be used by QE drivers.
>>>>>>
>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>>>> ---
>>>>>> arch/powerpc/sysdev/qe_lib/ucc.c      |    7 +++++++
>>>>>> arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
>>>>>> arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 ++++++++++--
>>>>>> 3 files changed, 25 insertions(+), 2 deletions(-)
>>>>>
>>
>> What happened with this?
>
> This has been merged as commit  
> 65482ccf9d00bf4f68e17eb9c656d045d26e5d1f.

Ignore me I see the commit.  Timur will just need to EXPORT_SYMBOL()  
what additional functions he needs for the uart driver.

- k
