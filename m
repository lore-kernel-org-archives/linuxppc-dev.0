Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 690EB1A1D49
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 05:06:45 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so118659843igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 12:06:43 -0700 (PDT)
Message-ID: <55CB9942.7050303@gmail.com>
Date: Wed, 12 Aug 2015 15:06:42 -0400
From: nick <xerofoify@gmail.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, gleb@kernel.org
CC: linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm:powerpc:Fix incorrect return statement in the function
 mpic_set_default_irq_routing
References: <1438962893-3370-1-git-send-email-xerofoify@gmail.com>
 <55CB98FE.4060908@suse.de>
In-Reply-To: <55CB98FE.4060908@suse.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2015-08-12 03:05 PM, Alexander Graf wrote:
> 
> 
> On 07.08.15 17:54, Nicholas Krause wrote:
>> This fixes the incorrect return statement in the function
>> mpic_set_default_irq_routing from always returning zero
>> to signal success to this function's caller to instead
>> return the return value of kvm_set_irq_routing as this
>> function can fail and we need to correctly signal the
>> caller of mpic_set_default_irq_routing when the call
>> to this particular function has failed.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> 
> I like the patch, but I don't see it on the kvm-ppc mailing list. It
> doesn't show up on patchwork or spinics. Did something go wrong while
> sending it out?
> 
> 
> Alex
> 
Alex,
Ask Paolo about it as he would be able to explain it better then I.
Nick
