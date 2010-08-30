Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DECBBB7100
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 17:35:50 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id o7U7Zi9S016539
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 13:05:44 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7U7ZiBA4509774
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 13:05:44 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7U7Zhlg006547
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 13:05:44 +0530
Message-ID: <4C7B5F4C.4000001@linux.vnet.ibm.com>
Date: Mon, 30 Aug 2010 13:05:40 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Power machines fail to boot after build being successful
References: <4C764F52.5050707@linux.vnet.ibm.com> <2311.1282871746@neuling.org>
	<20100827120144.1736a2f6.sfr@canb.auug.org.au>
	<4C7B4C1F.7010003@linux.vnet.ibm.com>
	<21473.1283150987@neuling.org>
In-Reply-To: <21473.1283150987@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 30 August 2010 12:19 PM, Michael Neuling wrote:
> In message<4C7B4C1F.7010003@linux.vnet.ibm.com>  you wrote:
>    
>> On Friday 27 August 2010 07:31 AM, Stephen Rothwell wrote:
>>      
>>> Hi Mikey,
>>>
>>> On Fri, 27 Aug 2010 11:15:46 +1000 Michael Neuling<mikey@neuling.org>   wrot
>>>        
> e:
>    
>>>
>>>        
>>>>
>>>>          
>>>>> After successfully building the kernel version
>>>>> 2.6.36-rc2-git4(commitid d4348c678977c) with the config file
>>>>> attached(used make oldconfig), P5 and P6 power machines fails to
>>>>> reboot with the following logs
>>>>>
>>>>> Logs collected while rebooting into today next, same occurs with the
>>>>> upstream kernel too.
>>>>>
>>>>>            
>>>> This will fix your problem:
>>>> http://patchwork.ozlabs.org/patch/62757/
>>>>
>>>>          
>>> I have seen something similar in my linux-next boot tests, so I will add
>>> this patch to linux-next for today.
>>>
>>>        
>> Hi,
>>
>> The same problem occurs on the linux-tree , now that since the patch
>> is integrated into linux-next, im not able to find the problem with
>> linux-next-20100827.
>>
>> When will the patch be integrated with the linux-tree.
>>      
> By "the linux-tree" do you mean Linus' tree?
>
> If so, benh is likely to ask Linus to pull the fix in the next few days.
>
> Mikey
>    
Yes i mean to say Linus' tree.ccing benh.

Divya
