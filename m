Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2D64B7BA7
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 07:28:30 +1100 (EST)
Subject: Re: Linux for MPC5554 or MPC5534 (core e200z6)?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4ADF2693.8060308@freemail.hu>
Date: Wed, 21 Oct 2009 15:28:09 -0500
Message-Id: <37BBF659-C12F-4A6A-BD0B-5C199986B4B1@kernel.crashing.org>
References: <4ADE37DC.4070909@freemail.hu>
	<2AA28D4C-4624-47B9-A201-EB55F5C1C139@kernel.crashing.org>
	<4ADF2693.8060308@freemail.hu>
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 21, 2009, at 10:19 AM, N=E9meth M=E1rton wrote:

> Kumar Gala wrote:
>> On Oct 20, 2009, at 5:21 PM, N=E9meth M=E1rton wrote:
>>
>>> Hi Grant,
>>> Hello List,
>>>
>>> is there anybody who was successfully run Linux kernel on Freescale
>>> MPC5554
>>> [1], [2] or on Freescale MPC5534 [3], [4]? Both of these embedded
>>> PowerPC
>>> controllers have the e200z6 core.
>>>
>>> Is there anybody who is working with these controllers or with the
>>> e200z6 core?
>>>
>>> References:
>>> [1] Freescale MPC5554
>>>   =
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPC5554
>>>
>>> [2] MPC5553/MPC5554 Microcontroller Reference Manual
>>>   =
http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf=

>>>
>>> [3] Freescale MPC5534
>>> =
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPC5534
>>>
>>> [4] MPC5534 Microcontroller Reference Manual
>>>   http://www.freescale.com/files/32bit/doc/ref_manual/MPC5534RM.pdf
>>
>> I'm not aware of anyone working on Linux for these chips based on the
>> e200z6.  What application do you have that you want to run Linux on
>> them?
>
> At this time I am just looking to see what kind of operating systems =20=

> these
> chips can run. I think the first step to run Linux would be that the =20=

> MMU
> and serial console starts to work then maybe I would check how the =20
> PF_CAN
> interface ( http://lwn.net/Articles/253425/ ) would work on this =20
> device
> if a FlexCAN2 driver is available.
>
> Is there any other powerpc port with e200z6 core?

I'm not aware of any other parts w/the e2002z6 core.  The MMU code =20
exists in the kernel for e200, but probably needs some updating/=20
rehashing.

- k=
