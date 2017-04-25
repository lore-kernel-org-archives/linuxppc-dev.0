Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC0Cn2WHdzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 20:42:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org
Cc: paulus@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH] kvm: powerpc: book3s: use local_paca instead of get_paca
In-Reply-To: <CAOJe8K1qyg4KwMPoniJMvk1-EJmQRvGh8Efn934WGGASzf03ug@mail.gmail.com>
References: <1490784937-10593-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K1qyg4KwMPoniJMvk1-EJmQRvGh8Efn934WGGASzf03ug@mail.gmail.com>
Date: Tue, 25 Apr 2017 20:42:41 +1000
Message-ID: <877f283h0e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:

> On 3/29/17, Denis Kirjanov <kda@linux-powerpc.org> wrote:
>> with CONFIG_DEBUG_PREEMPT get_paca produces the following warning
>> in kvmppc_book3s_init_hv since we are getting into the
>> smp_processor_id debugging code
>>
>> There is no real issue with the xics_phys field.
>> If paca->kvm_hstate.xics_phys is non-zero on one cpu, it will be
>> non-zero on them all.  Therefore this is not fixing any actual
>> problem, just the warning.
>
> Hey Michael,
>
> are you going to take the patch?

It's in KVM code, so technically Paul should take it.

I'll see if it is likely to conflict with anything in his tree and if
not I'll merge it.

cheers
