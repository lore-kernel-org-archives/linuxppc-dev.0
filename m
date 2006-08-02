Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16E4367BDF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:30:34 +1000 (EST)
In-Reply-To: <1154549483.19994.46.camel@cashmere.sps.mot.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
	<1154549483.19994.46.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
Date: Wed, 2 Aug 2006 15:30:09 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2006, at 3:11 PM, Jon Loeliger wrote:

> On Wed, 2006-08-02 at 14:24, Kumar Gala wrote:
>> On Aug 2, 2006, at 1:48 PM, Jon Loeliger wrote:
>>
>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>>> ---
>>>
>>> As per list discussion, let's add device tree source files
>>> under powerpc/boot/dts.  If nothing else, it is a starting point.
>>>
>>>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |  338 +++++++++++++++++++++
>>> +++++++++++
>>>  1 files changed, 338 insertions(+), 0 deletions(-)
>>
>> Do we want to go ahead and fix the mac address field having the wrong
>> name?
>>
>> - kumar
>
>
> Yeah, we have lined up Matt to make a comprehensive
> update for this.  Can we take my patch as-is?  Matt will
> follow up with a clean sweep, including fsl_socl.c, to
> fix it all in one swell foop.

I think this is one that is clearly something that should be fixed  
before acceptance.  Since we are talking about a dozen lines of  
modifications.  Especially since at this point having the .dts in the  
tree doesn't really effect anything inside the kernel tree.

- kumar

>>> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/
>>> boot/dts/mpc8641_hpcn.dts
>>> new file mode 100644
>>> index 0000000..55a8167
>>> --- /dev/null
>>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>> @@ -0,0 +1,338 @@
>>> +/*
>>> + * MPC8641 HPCN Device Tree Source
>>> + *
>
> Any chance we can avoid quoting-back the largely irrelevant
> parts of a post like this in the future?
>
> Thanks,
> jdl
>
>
