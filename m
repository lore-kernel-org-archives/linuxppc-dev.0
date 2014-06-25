Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38D5A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 09:59:31 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id v10so2238112pde.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 16:59:29 -0700 (PDT)
Message-ID: <53AB625A.5040305@ozlabs.ru>
Date: Thu, 26 Jun 2014 09:59:22 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Prepare for in-kernel VFIO DMA operations acceleration
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
 <53905B14.5020204@suse.de> <5391094D.7090104@ozlabs.ru>
 <53AB3B28.3040708@suse.de>
In-Reply-To: <53AB3B28.3040708@suse.de>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2014 07:12 AM, Alexander Graf wrote:
> 
> On 06.06.14 02:20, Alexey Kardashevskiy wrote:
>> On 06/05/2014 09:57 PM, Alexander Graf wrote:
>>> On 05.06.14 09:25, Alexey Kardashevskiy wrote:
>>>> This reserves 2 capability numbers.
>>>>
>>>> This implements an extended version of KVM_CREATE_SPAPR_TCE_64 ioctl.
>>>>
>>>> Please advise how to proceed with these patches as I suspect that
>>>> first two should go via Paolo's tree while the last one via Alex Graf's
>>>> tree
>>>> (correct?).
>>> They would just go via my tree, but only be actually allocated (read:
>>> mergable to qemu) when they hit Paolo's tree.
>>>
>>> In fact, I don't think it makes sense to split them off at all.
>>
>> So? Are these patches going anywhere? Thanks.
> 
> So? Are you going to address the comments?

Sorry, I cannot find here anything to fix. Ben asked some questions, I
answered and there were no objections. What do I miss this time?...


-- 
Alexey
