Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9227CDE013
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 02:14:12 +1000 (EST)
In-Reply-To: <20070411.212548.95037188.davem@davemloft.net>
References: <20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070411.212548.95037188.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F3BE390-906F-4B14-92DB-BA6BB191D022@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH,RFC] Split out common parts of prom.h
Date: Thu, 12 Apr 2007 11:13:47 -0500
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 11, 2007, at 11:25 PM, David Miller wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 12 Apr 2007 14:19:05 +1000
>
>> This applies on top of all the previous patches I sent (including  
>> a merge
>> of the sparc64 and powerpc for-2.6.22 trees).  So if people can't  
>> get it
>> to apply, at least I would like some comments on the direction. (I  
>> told
>> Rusty about the circular inclusion below and he didn't throw up, so I
>> figure it isn't too bad as a temporary measure.)
>>
>> I have built allmodconfig (modified slightly) for Powerpc, Sparc64  
>> and
>> Sparc.  (All of which fail during the module post processing but for
>> reasons not related to these patches as far as I can see.)
>
> This is one approach, and I'm not against it.
>
> Another way is to create a linux/openfw.h that does nothing
> but include asm/prom.h as step 1.  Step 2 is to convert all
> the include sites, and step 3 is to move the relevant
> prom.h bits into openfw.h
>
> To be honest, since you're the one doing all of the hard work I think
> you should be allowed to make the choice on how to go about this :-)

Should we drop prom.h all together.  I haven't looked but I would  
think OLPC would need (or use) some of this as well since its using OF.

- k
