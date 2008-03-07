Return-Path: <pbadari@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33D40DE188
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 03:44:58 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m27GiqTW023424
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Mar 2008 11:44:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m27GipYx191580
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Mar 2008 09:44:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m27Gip4r023212
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Mar 2008 09:44:51 -0700
Message-ID: <47D17102.2000001@us.ibm.com>
Date: Fri, 07 Mar 2008 08:44:50 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] generic __remove_pages() support
References: <1204836859.4772.32.camel@nimitz.home.sr71.net>
	<1204839763.6272.8.camel@dyn9047017100.beaverton.ibm.com>
	<20080307102032.A17D.E1E9C6FF@jp.fujitsu.com>
In-Reply-To: <20080307102032.A17D.E1E9C6FF@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yasunori Goto wrote:
> Hi Badari-san.
>
>   
>> On Thu, 2008-03-06 at 12:54 -0800, Dave Hansen wrote:
>>     
>>> On Thu, 2008-03-06 at 10:55 -0800, Badari Pulavarty wrote:
>>>       
>>>> +               if (memmap)
>>>> +                       __kfree_section_memmap(memmap, PAGES_PER_SECTION);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Allocations came from bootmem - how do I free up ?
>>>> +        */
>>>> +
>>>>         
>>> Shouldn't we figure this one out before merging?
>>>
>>> I think we at least need a printk() there.
>>>       
>> I can add a printk(). I am hoping Yasunori Goto has something to
>> handle this, before we really merge into mainline.
>>     
>
> Ah, yes. 
> I'm making patches for around here. I'm sorry for your waiting.
>
> BTW, do you hurry for merging your patch? 
> To be honest, I would like to solve not only here
> but also some other issues.
> But, if you hurry, I'll concentrate to solve only this.
>
> Bye.
>   
I am hoping to merge this into 2.6.26. I am not in a hurry, but would like
to make sure some one is working on the issue. If you have something
to test, feel free to pass it to me - I will be happy to test.

Thanks,
Badari
