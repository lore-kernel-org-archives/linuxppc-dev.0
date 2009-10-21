Return-Path: <nm127@freemail.hu>
Received: from mail02d.mail.t-online.hu (mail02d.mail.t-online.hu [84.2.42.7])
	by ozlabs.org (Postfix) with ESMTP id 2D86DB7B70
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 02:29:33 +1100 (EST)
Message-ID: <4ADF2693.8060308@freemail.hu>
Date: Wed, 21 Oct 2009 17:19:47 +0200
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linux for MPC5554 or MPC5534 (core e200z6)?
References: <4ADE37DC.4070909@freemail.hu>
	<2AA28D4C-4624-47B9-A201-EB55F5C1C139@kernel.crashing.org>
In-Reply-To: <2AA28D4C-4624-47B9-A201-EB55F5C1C139@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Oct 20, 2009, at 5:21 PM, Németh Márton wrote:
> 
>> Hi Grant,
>> Hello List,
>>
>> is there anybody who was successfully run Linux kernel on Freescale  
>> MPC5554
>> [1], [2] or on Freescale MPC5534 [3], [4]? Both of these embedded  
>> PowerPC
>> controllers have the e200z6 core.
>>
>> Is there anybody who is working with these controllers or with the  
>> e200z6 core?
>>
>> References:
>> [1] Freescale MPC5554
>>    http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5554
>>
>> [2] MPC5553/MPC5554 Microcontroller Reference Manual
>>    http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
>>
>> [3] Freescale MPC5534
>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC5534
>>
>> [4] MPC5534 Microcontroller Reference Manual
>>    http://www.freescale.com/files/32bit/doc/ref_manual/MPC5534RM.pdf
> 
> I'm not aware of anyone working on Linux for these chips based on the  
> e200z6.  What application do you have that you want to run Linux on  
> them?

At this time I am just looking to see what kind of operating systems these
chips can run. I think the first step to run Linux would be that the MMU
and serial console starts to work then maybe I would check how the PF_CAN
interface ( http://lwn.net/Articles/253425/ ) would work on this device
if a FlexCAN2 driver is available.

Is there any other powerpc port with e200z6 core?

Regards,

	Márton Németh
