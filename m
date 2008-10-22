Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B945EDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 05:59:14 +1100 (EST)
Date: Wed, 22 Oct 2008 22:59:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts
	files
Message-ID: <20081022185913.GA1828@oksana.dev.rtsoft.ru>
References: <20081021185844.GA31070@oksana.dev.rtsoft.ru>
	<48FF2CBB.7060605@genesi-usa.com>
	<20081022135046.GA30347@oksana.dev.rtsoft.ru>
	<48FF73B2.8040600@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48FF73B2.8040600@genesi-usa.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 01:40:50PM -0500, Matt Sealey wrote:
>
>
> Anton Vorontsov wrote:
>> On Wed, Oct 22, 2008 at 08:38:03AM -0500, Matt Sealey wrote:
>>> I'm extremely troubled that it is "not used in the code", surely  
>>> device_type is checked as a legacy for Open Firmware (otherwise a lot 
>>> of devices may never be detected!),
>>
>> Checked where? 
>
> of_find_device_by_type() goes through it and of_find_compatible_node() - 
> while not directly, checks the type field of the node which is filled in 
> from device_type BEFORE it checks the compatible property.

Yes, I know this.

> This isn't specific CHRP/FDT platform code it's in the generic tree 
> scanning functions.

I think I got it. ;-) You think that I'm not aware of that we _can_
use the device_type for matching the nodes. Well, I'm aware of it,
sure we can. ;-)

But we don't use it for the rtc nodes, and we don't want to encourage
the usage for the flat trees. And that's the point of this patch.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
