Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1ACF5DDF83
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 03:06:44 +1100 (EST)
In-Reply-To: <45A76663.4030705@246tNt.com>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
	<20070112104211.GQ11226@localhost.localdomain>
	<45A76663.4030705@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <787DAFF5-15AB-4610-8794-FA7C4B5BF87D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Fri, 12 Jan 2007 10:05:56 -0600
To: Sylvain Munaut <tnt@246tNt.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 4:43 AM, Sylvain Munaut wrote:

> Sascha Hauer wrote:
>> On Fri, Jan 12, 2007 at 10:00:31AM +0100, Sylvain Munaut wrote:
>>
>>> I'm not saying the system is perfect but this issue is more  
>>> related to
>>> recent
>>> bindings that the of thing as a whole. That's more the problem  
>>> with of
>>> is that
>>> when you need to define bindings for something that has none, you  
>>> may not
>>> anticipate everything ....
>>>
>>
>> No, you can never do that. Lets hope there will never be incompatible
>> changes in the device tree so that we have to use this device tree  
>> for this
>> kernel version and another one for other kernel versions.
>>
> I would *not* base anything (production) on the current bindings,  
> because
> the changes we consider now are pretty "basic" and not compatible.
>
> But it's clear that it's probably the last opportunity we have to do
> such changes,
> afterwards we'll be bound to whatever we decide in the next few weeks.

Do realize you can use the device tree in a much simpler form to pass  
the same basic information we got from the bd_t and ignore everything  
else.

The reason for all the churn (or complexity) is the lack of any  
'spec' on how to describe any of the SOC parts in the device-tree and  
thus we have to invent something.

At least that's how I see it.

- k
