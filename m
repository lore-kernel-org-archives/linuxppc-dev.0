Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F47DB70F1
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 16:13:57 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o7U69Qt7015308
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 16:09:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7U6DuN92212046
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 16:13:56 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7U6Du1a029816
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Aug 2010 16:13:56 +1000
Message-ID: <4C7B4C1F.7010003@linux.vnet.ibm.com>
Date: Mon, 30 Aug 2010 11:43:51 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Power machines fail to boot after build being successful
References: <4C764F52.5050707@linux.vnet.ibm.com> <2311.1282871746@neuling.org>
	<20100827120144.1736a2f6.sfr@canb.auug.org.au>
In-Reply-To: <20100827120144.1736a2f6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 27 August 2010 07:31 AM, Stephen Rothwell wrote:
> Hi Mikey,
>
> On Fri, 27 Aug 2010 11:15:46 +1000 Michael Neuling<mikey@neuling.org>  wrote:
>    
>>      
>>> After successfully building the kernel version
>>> 2.6.36-rc2-git4(commitid d4348c678977c) with the config file
>>> attached(used make oldconfig), P5 and P6 power machines fails to
>>> reboot with the following logs
>>>
>>> Logs collected while rebooting into today next, same occurs with the
>>> upstream kernel too.
>>>        
>> This will fix your problem:
>> http://patchwork.ozlabs.org/patch/62757/
>>      
> I have seen something similar in my linux-next boot tests, so I will add
> this patch to linux-next for today.
>    
Hi,

The same problem occurs on the linux-tree , now that since the patch is integrated into linux-next,
im not able to find the problem with linux-next-20100827.

When will the patch be integrated with the linux-tree.

Thanks
Divya
