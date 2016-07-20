Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvXxT3MNDzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 20:21:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org, paulus@samba.org,
 david@gibson.dropbear.id.au, Radim =?utf-8?B?S3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
In-Reply-To: <ee83aaeb-40cf-4b46-4ae0-bb4265a0e610@redhat.com>
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
 <20534.8713825972$1468993677@news.gmane.org>
 <ee83aaeb-40cf-4b46-4ae0-bb4265a0e610@redhat.com>
Date: Wed, 20 Jul 2016 20:20:57 +1000
Message-ID: <87r3aohapi.fsf@@concordia.ellerman.id.au>
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 20/07/2016 07:46, Michael Ellerman wrote:
>> Thanks.
>> 
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>> 
>> Or do you want me to merge this before Paul gets back?
>
> No, this should be merged through the KVM tree.  Please Cc the KVM
> maintainers before offering to apply a patch that formally belongs to
> another tree.

Yeah OK. It was just an offer, because I know the Qemu side is blocked
until this goes in.

> In particular this patch would indeed have a conflict, because you have
>
> +#define KVM_CAP_PPC_HTM 129
>
> but cap numbers 129 and 130 are already taken.  So whoever applies it
> should bump the number to 131.

Yep, I know about KVM caps, I probably would have remembered to check
the KVM tree. At the very least it would have got caught in linux-next.

cheers
