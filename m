Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BF34DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:36:56 +1100 (EST)
Message-Id: <70447F10-2DE5-46CA-B7ED-4EC68C5A1996@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080123102800.409e146f.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2 2/2] MPC8641 HPCN: call of_platform_bus_probe()
Date: Tue, 22 Jan 2008 17:36:28 -0600
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
	<1201033065.5716.175.camel@rhino>
	<20080123102800.409e146f.sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 5:28 PM, Stephen Rothwell wrote:

> On Tue, 22 Jan 2008 13:17:45 -0700 Wade Farnsworth <wfarnsworth@mvista.com 
> > wrote:
>>
>> +static struct of_device_id of_bus_ids[] = {
>
> You forgot the __initdata.

I've fixed it.

- k
