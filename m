Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E811DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 12:54:46 +1100 (EST)
Message-Id: <3C9ED1A8-7F51-41B8-898C-45BDA3EF4548@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080124115018.69551acf.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/4 v4] POWERPC: Add initial iomega StorCenter board port.
Date: Wed, 23 Jan 2008 19:54:29 -0600
References: <E1JHkYk-00010g-M2@jdl.com>
	<20080124115018.69551acf.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 6:50 PM, Stephen Rothwell wrote:

> Hi Jon,
>
> On Wed, 23 Jan 2008 12:42:50 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>>
>> +++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
>> +static void __init storcenter_init_IRQ(void)
>> +{
>> +	struct mpic *mpic;
>> +	struct device_node *dnp;
>> +	const void *prop;
>> +	int size;
>> +	phys_addr_t paddr;
>> +
>> +	dnp = of_find_node_by_type(NULL, "open-pic");
>> +	if (dnp == NULL)
>> +		return;
>> +
>> +	prop = of_get_property(dnp, "reg", &size);
>> +	if (prop == NULL)
>> +		return;
>
> You need an of_node_put(dnp) before you return.

Fixed up by your friendly maintainer.

- k
