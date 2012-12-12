Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B4F62C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 11:29:25 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: Fix SREGS documentation reference
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CAFeW=pb9Afawnp7hi6Muzs7HU=TVeKDX4RD6Tw0bMkkY9-TTBw@mail.gmail.com>
Date: Wed, 12 Dec 2012 01:29:15 +0100
Message-Id: <3B61A067-1AF0-4E66-995E-2B83EB0BBCDB@suse.de>
References: <1355233103-14587-1-git-send-email-mihai.caraman@freescale.com>
 <CAFeW=pb9Afawnp7hi6Muzs7HU=TVeKDX4RD6Tw0bMkkY9-TTBw@mail.gmail.com>
To: Amos Kong <kongjianjun@gmail.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.12.2012, at 15:22, Amos Kong wrote:

> On Tue, Dec 11, 2012 at 9:38 PM, Mihai Caraman
> <mihai.caraman@freescale.com> wrote:
>>=20
>> Reflect the uapi folder change in SREGS API documentation.
>>=20
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>> Documentation/virtual/kvm/api.txt |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/Documentation/virtual/kvm/api.txt =
b/Documentation/virtual/kvm/api.txt
>> index a4df553..9cf591d 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -345,7 +345,7 @@ struct kvm_sregs {
>>        __u64 interrupt_bitmap[(KVM_NR_INTERRUPTS + 63) / 64];
>> };
>>=20
>> -/* ppc -- see arch/powerpc/include/asm/kvm.h */
>> +/* ppc -- see arch/powerpc/include/uapi/asm/kvm.h */
>=20
> Trivial fix.
> Reviewed-by: Amos Kong <kongjianjun@gmail.com>

Thanks, applied to kvm-ppc-next.


Alex
