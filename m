Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A90EDDF1B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 01:06:21 +1100 (EST)
Message-ID: <4797499A.3020506@freescale.com>
Date: Wed, 23 Jan 2008 08:05:14 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3 v3] Add initial iomega StorCenter board port.
References: <E1JHRkl-0005e5-RX@jdl.com>
	<20080123105111.125f075d.sfr@canb.auug.org.au>
In-Reply-To: <20080123105111.125f075d.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Jon,
> 
> On Tue, 22 Jan 2008 16:37:59 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>> +++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
> 
>> +extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
> 
> This clearly needs to be decalred in some header file.  (I know you did
> not introduce it.)  In arch/ppc, it was declared in asm/system.h (but I
> don't know if that is appropriate for arch/powerpc).  Maybe you could do
> a preceeding patch that does this and fixes the other user.

I hear my Janitorial Karmic Duty calling.
 
>> +static void __init storcenter_init_IRQ(void)

>> +	prop = of_get_property(dnp, "reg", &size);
>> +	paddr = (phys_addr_t)of_translate_address(dnp, prop);
> 
> What happens of "prop" is NULL?

Someone should fix that case too. :-)

Kumar,

I'll respin this trio for you.

jdl
