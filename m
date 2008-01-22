Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6EDFDDE42
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 03:52:14 +1100 (EST)
Message-Id: <834ADDC8-2689-4936-BA0B-768D68288EC9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1201020463.5716.161.camel@rhino>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/2] Add flash node to mpc8641_hpcn.dts
Date: Tue, 22 Jan 2008 10:49:10 -0600
References: <1201019917.5716.154.camel@rhino>
	<06AA1424-0697-4AF8-B843-945211A5B54A@kernel.crashing.org>
	<1201020463.5716.161.camel@rhino>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 22, 2008, at 10:47 AM, Wade Farnsworth wrote:

> On Tue, 2008-01-22 at 10:44 -0600, Kumar Gala wrote:
>> On Jan 22, 2008, at 10:38 AM, Wade Farnsworth wrote:
>>
>>> Add flash and partition information to mpc8641_hpcn.dts
>>>
>>> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
>>>
>>> ---
>>> arch/powerpc/boot/dts/mpc8641_hpcn.dts |   27 +++++++++++++++++++++ 
>>> ++
>>> 1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/
>>> boot/dts/mpc8641_hpcn.dts
>>> index a719179..679e857 100644
>>> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>>> @@ -457,4 +457,31 @@
>>> 				  0 00100000>;
>>> 		};
>>> 	};
>>
>> This really should be under a localbus node.
>>
>> - k
>>
>
> Ok. I'll fix it up and resend.

look at the mpc8313erdb.dts (in my tree, as an example).

- k
