Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BAE31A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 10:20:38 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id v10so1776463pde.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jun 2014 17:20:35 -0700 (PDT)
Message-ID: <5391094D.7090104@ozlabs.ru>
Date: Fri, 06 Jun 2014 10:20:29 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Prepare for in-kernel VFIO DMA operations acceleration
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
 <53905B14.5020204@suse.de>
In-Reply-To: <53905B14.5020204@suse.de>
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

On 06/05/2014 09:57 PM, Alexander Graf wrote:
> 
> On 05.06.14 09:25, Alexey Kardashevskiy wrote:
>> This reserves 2 capability numbers.
>>
>> This implements an extended version of KVM_CREATE_SPAPR_TCE_64 ioctl.
>>
>> Please advise how to proceed with these patches as I suspect that
>> first two should go via Paolo's tree while the last one via Alex Graf's tree
>> (correct?).
> 
> They would just go via my tree, but only be actually allocated (read:
> mergable to qemu) when they hit Paolo's tree.
> 
> In fact, I don't think it makes sense to split them off at all.


So? Are these patches going anywhere? Thanks.


-- 
Alexey
