Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id BEC9267A06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:31:43 +1000 (EST)
Message-ID: <42B049DC.7040703@ru.mvista.com>
Date: Wed, 15 Jun 2005 19:31:40 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42AFDEFE.2040508@ru.mvista.com>
	<2731d19a2e3b9413db32be59726a4c82@freescale.com>
In-Reply-To: <2731d19a2e3b9413db32be59726a4c82@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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
> On Jun 15, 2005, at 2:55 AM, Vitaly Bordug wrote:
>
>> Kumar,
>> I assume this as a IMMR enumerating you promised to help with. Is it in
>> the final state? And what was the reason of fcc_regs_c removal?
>> I'm also going to change the files name to cpm2_.. .
>
>
> Yes, I removed the fcc_regs_c since its not always true.  Please don't 
> rename the file to cpm2_.  I think I'm going to end up renaming them 
> to pq2_ since that is the most appropriate name.  I'd say we are about 
> 80% the way to a final patch.
>
Great. Apart of naming issue - what else remaining to do?
I mean how can I contribute to speed-up this?

-- 
Sincerely, 
Vitaly
