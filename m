Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTCk81vGLzDvy8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:09:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>,
 Balbir Singh <bsingharora@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] PPC/CAS Add support for power9 in ibm_architecture_vec
In-Reply-To: <CAOJe8K0z7tAMffWUobZOiStq3YLtNHHixf2bM6gDV8Qh_Eioig@mail.gmail.com>
References: <9b7467b2-a9f3-07a2-f32c-4f8d64735057@gmail.com>
 <CAOJe8K0z7tAMffWUobZOiStq3YLtNHHixf2bM6gDV8Qh_Eioig@mail.gmail.com>
Date: Wed, 30 Nov 2016 19:09:19 +1100
Message-ID: <87a8chpexc.fsf@concordia.ellerman.id.au>
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

> On 11/29/16, Balbir Singh <bsingharora@gmail.com> wrote:
>>
>>
>> The PVR list has been updated and IBM_ARCH_VEC_NRCORES_OFFSET.
>> This provides the cpu versions supported to the hypervisor and in this case
>> tells the hypervisor that the guest supports ISA 3.0 and Power9.
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>
> Michael rewrote the code so you have to update the patch.
> See https://patchwork.ozlabs.org/patch/658627/

Yeah, but no one reviewed it ...

But yep I've merged it anyway.

I would just fix this up on top of that, but I don't have a good way to
test it, so Balbir I will bounce this back to you to rebase on top of my
patch.

cheers
