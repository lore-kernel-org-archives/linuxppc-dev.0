Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB4591A1DD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 05:13:00 +1000 (AEST)
Subject: Re: [PATCH] kvm:powerpc:Fix incorrect return statement in the
 function mpic_set_default_irq_routing
To: nick <xerofoify@gmail.com>, gleb@kernel.org
References: <1438962893-3370-1-git-send-email-xerofoify@gmail.com>
 <55CB98FE.4060908@suse.de> <55CB9942.7050303@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <55CB9AB8.9000104@suse.de>
Date: Wed, 12 Aug 2015 21:12:56 +0200
MIME-Version: 1.0
In-Reply-To: <55CB9942.7050303@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12.08.15 21:06, nick wrote:
> 
> 
> On 2015-08-12 03:05 PM, Alexander Graf wrote:
>>
>>
>> On 07.08.15 17:54, Nicholas Krause wrote:
>>> This fixes the incorrect return statement in the function
>>> mpic_set_default_irq_routing from always returning zero
>>> to signal success to this function's caller to instead
>>> return the return value of kvm_set_irq_routing as this
>>> function can fail and we need to correctly signal the
>>> caller of mpic_set_default_irq_routing when the call
>>> to this particular function has failed.
>>>
>>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>>
>> I like the patch, but I don't see it on the kvm-ppc mailing list. It
>> doesn't show up on patchwork or spinics. Did something go wrong while
>> sending it out?
>>
>>
>> Alex
>>
> Alex,
> Ask Paolo about it as he would be able to explain it better then I.

Well, whatever the reason, I can only apply patches that actually
appeared on the public mailing list. Otherwise people may not get the
chance to review them ;).


Alex
