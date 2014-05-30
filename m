Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B415E1A06CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 17:44:41 +1000 (EST)
Message-ID: <538836E3.1060600@suse.de>
Date: Fri, 30 May 2014 09:44:35 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/pseries: Use new defines when calling h_set_mode
References: <1401106626-13130-1-git-send-email-paulus@samba.org>	
 <1401106626-13130-4-git-send-email-paulus@samba.org>	
 <5385E620.5090703@suse.de> <1401342462.4116.4.camel@ale.ozlabs.ibm.com>	
 <1401344549.4116.8.camel@ale.ozlabs.ibm.com>	
 <BD1CF085-FEBC-4208-AD3F-C55DB002097F@suse.de>	
 <1401349547.4116.19.camel@ale.ozlabs.ibm.com> <5387A63B.4000503@suse.de>
 <1401400361.14938.16.camel@pasglop>
In-Reply-To: <1401400361.14938.16.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.05.14 23:52, Benjamin Herrenschmidt wrote:
> On Thu, 2014-05-29 at 23:27 +0200, Alexander Graf wrote:
>> On 29.05.14 09:45, Michael Neuling wrote:
>>>>> +/* Values for 2nd argument to H_SET_MODE */
>>>>> +#define H_SET_MODE_RESOURCE_SET_CIABR        1
>>>>> +#define H_SET_MODE_RESOURCE_SET_DAWR        2
>>>>> +#define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE    3
>>>>> +#define H_SET_MODE_RESOURCE_LE            4
>>>> Much better, but I think you want to make use of these in non-kvm code too,
>>>> no? At least the LE one is definitely already implemented as call :)
>>> Sure but that's a different patch.... below.
>> Ben, how would you like to handle these 2 patches? If you give me an ack
>> I can just put this patch into my kvm queue. Alternatively we could both
>> carry a patch that adds the H_SET_MODE header bits only and whoever hits
>> Linus' tree first wins ;).
> No biggie. Worst case it's a trivial conflict.

Well, the way the patches are split right now it won't be a conflict, 
but a build failure on either side.


Alex
