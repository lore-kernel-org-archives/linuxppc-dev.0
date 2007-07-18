Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12E1EDDDE4
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 06:08:56 +1000 (EST)
Message-ID: <469E7350.3090308@freescale.com>
Date: Wed, 18 Jul 2007 15:08:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013611.GY15238@ld0162-tx32.am.freescale.net>
	<20070718032857.GF18251@localhost.localdomain>
	<F5E8139F-E8DA-4C41-8B90-E727FD4E346C@kernel.crashing.org>
In-Reply-To: <F5E8139F-E8DA-4C41-8B90-E727FD4E346C@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jul 17, 2007, at 10:28 PM, David Gibson wrote:
>> Hrm... I for one would be a lot more comfortable with this patch if
>> you had a theoretical explanation for why it's necessary, in addition
>> to the "seems to fix things".

Sure, so would I; I just wanted to point out the issue, and make 
available a quick fix for anyone else that might be having problems.

My theoretical explanation is that the hardware is broken. :-P

> I agree w/David.  Have you tried turning on the  CPU_FTR_NEED_COHERENT?  
> Take a look at include/asm-powerpc/cputable.h  and search for the 
> reference to CONFIG_PPC_83xx.

OK, that appears to work as well.

-Scott
