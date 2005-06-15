Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id C00C667B62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 02:07:44 +1000 (EST)
Message-ID: <42B0524E.6030200@ru.mvista.com>
Date: Wed, 15 Jun 2005 20:07:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42B049DC.7040703@ru.mvista.com>
	<7e2a8c0e483e5dfdc532c47d20776bbd@freescale.com>
In-Reply-To: <7e2a8c0e483e5dfdc532c47d20776bbd@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>
> On Jun 15, 2005, at 10:31 AM, Vitaly Bordug wrote:
>
>> Kumar Gala wrote:
>>
>>>
>>> On Jun 15, 2005, at 2:55 AM, Vitaly Bordug wrote:
>>>
>>>> Kumar,
>>>> I assume this as a IMMR enumerating you promised to help with. Is 
>>>> it in
>>>> the final state? And what was the reason of fcc_regs_c removal?
>>>> I'm also going to change the files name to cpm2_.. .
>>>
>>>
>>>
>>> Yes, I removed the fcc_regs_c since its not always true.  Please don't
>>> rename the file to cpm2_.  I think I'm going to end up renaming them
>>> to pq2_ since that is the most appropriate name.  I'd say we are about
>>> 80% the way to a final patch.
>>>
>> Great. Apart of naming issue - what else remaining to do?
>> I mean how can I contribute to speed-up this?
>
>
> At this point, I think a bit more discussion is going to be needed on 
> if SI1, SI2, and CPM are "devices" or not.
>
> Also, does the proposed FCC defn. sufficient or do we need the 
> extended registers that exist on some of the newer PQ2/PQ3 devices?  I 
> wasn't sure if the drivers used them or not.
>
fs_enet uses fcc_regs_c but only as a pass to the generic ethtool stuff 
but I'm not currently aware if it's compulsory. I guess FCC's mem(used 
to be IORESORCE) will be passed through platform_info but... Well, we 
have tiptridx etc. stuff that wants DPRAM offsets but pad area has to be 
real address. I'm still not sure how to handle this correct...

> - kumar
>
>


-- 
Sincerely, 
Vitaly
