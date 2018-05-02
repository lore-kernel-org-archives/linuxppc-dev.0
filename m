Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0074.outbound.protection.outlook.com [104.47.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bWnN0RP5zF2SD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 18:35:35 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Alexander
 Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/kvm/booke: fix altivec related build break
Date: Wed, 2 May 2018 08:35:28 +0000
Message-ID: <5AE9784E.7020304@nxp.com>
References: <20180426123319.10843-1-laurentiu.tudor@nxp.com>
 <874ljx5g6q.fsf@concordia.ellerman.id.au>
In-Reply-To: <874ljx5g6q.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 04/27/2018 09:14 AM, Michael Ellerman wrote:
> laurentiu.tudor@nxp.com writes:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Add missing "altivec unavailable" interrupt injection helper
>> thus fixing the linker error below:
>>
>> arch/powerpc/kvm/emulate_loadstore.o: In function `kvmppc_check_altivec_=
disabled':
>> arch/powerpc/kvm/emulate_loadstore.c: undefined reference to `.kvmppc_co=
re_queue_vec_unavail'
>>
>> Fixes: 09f984961c137c4b ("KVM: PPC: Book3S: Add MMIO emulation for VMX i=
nstructions")
>
> What config are you using to hit this? I'd like to add it to my
> auto-builder to catch it in future.
>

Start with the corenet64_smp_defconfig and enable CONFIG_KVM_E500MC=20
option found in "Virtualization -> KVM support for PowerPC=20
E500MC/E5500/E6500 processors".

P.S. Sorry for the late reply. I took advantage of labor day and=20
arranged a mini-vacation. :-)

---
Best Regards, Laurentiu=
