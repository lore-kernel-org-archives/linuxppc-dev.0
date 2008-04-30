Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8882DDDF54
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:49:55 +1000 (EST)
Message-Id: <F4E7A0B8-894F-4903-855E-6A4BE63CF8D5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209591750.18023.233.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWERPC] devres: Add devm_ioremap_flags()
Date: Wed, 30 Apr 2008 16:49:05 -0500
References: <Pine.LNX.4.64.0804301106010.22992@blarg.am.freescale.net>
	<1209591750.18023.233.camel@pasglop>
Cc: Andrew Morton <akpm@osdl.org>, htejun@gmail.com,
	Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Emilian.Medve@Freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 4:42 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 11:08 -0500, Kumar Gala wrote:
>> From: Emil Medve <Emilian.Medve@Freescale.com>
>>
>> We provide an ioremap_flags so provide a coresphonding  
>> devm_ioremap_flags.
>>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> Forgot to commit the actual implemtation in arch/powerpc/lib/devres.c
>>
>> Which tree should this go through, powerpc.git?
>
> Let's call it ioremap_prot instead please. I'm about to change
> ioremap_flags to ioremap_prot anyways. Keep the flags/prot argument
> unsigned long for now (it can be argued it should be a pgprot but that
> hasn't been sorted out completely).

No problem.  I've always wondered why ioremap_* aren't better  
specified by generic code.

- k
