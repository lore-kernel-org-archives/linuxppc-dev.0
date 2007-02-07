Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 36BFBDDEB9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 03:43:57 +1100 (EST)
Message-ID: <45CA01C9.3020309@freescale.com>
Date: Wed, 07 Feb 2007 10:43:53 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <45C86715.6090600@freescale.com>
	<001EB06E-FC1D-4F0A-A910-8E08EE0B8CE2@kernel.crashing.org>
In-Reply-To: <001EB06E-FC1D-4F0A-A910-8E08EE0B8CE2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Feb 6, 2007, at 5:31 AM, Li Yang wrote:
> 
>> Get rid of private immrbar_virt_to_phys() routine and
>> use generic iopa().
> 
> Nack. iopa() isn't that generic, shouldn't we really be using the dma 
> mapping API here?

I'm having a hard time understanding what's wrong with iopa().  Is it because 
it's a 32-bit only function?  The memory has already been mapped with ioremap(), 
so why would we want to map it again?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
