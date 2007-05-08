Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08B1FDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 06:39:40 +1000 (EST)
In-Reply-To: <4640DDD8.4040001@freescale.com>
References: <20070508191758.GA26879@lixom.net> <4640DDD8.4040001@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E47D5F4-DD15-46D1-A947-3031D069486F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Current powerpc.git build failures
Date: Tue, 8 May 2007 15:38:35 -0500
To: Timur Tabi <timur@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, jdl@jdl.com,
	paulus@samba.org, arnd@ardnb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 8, 2007, at 3:30 PM, Timur Tabi wrote:

> Olof Johansson wrote:
>
>> powerpc.mpc8641_hpcn_defconfig:
>> In file included from include/asm-generic/pgtable-nopmd.h:6,
>>                  from include/asm/pgtable-ppc32.h:4,
>>                  from include/asm/pgtable.h:8,
>>                  from arch/powerpc/platforms/86xx/mpc86xx_smp.c:18:
>> include/asm-generic/pgtable-nopud.h:13: error: expected specifier- 
>> qualifier-list before 'pgd_t'
>
> This must have occurred in the past 24 hours because I built the  
> latest 8641 yesterday
> morning and it worked fine.  mpc86xx_smp.c has not changed since  
> February, so I'm guessing
> that some header file that mpc86xx_smp.c includes no longer  
> includes some other header.

I'm guessing this is from david gibson's  4level-fixup.h for ppc32  
patch.

- k
