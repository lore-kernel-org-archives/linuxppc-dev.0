Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHhFJ0bV2zDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 22:00:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Add more BPF in defconfig
In-Reply-To: <20170207075420.GJ4090@naverao1-tp.localdomain>
References: <20170206025544.3292-1-mikey@neuling.org>
 <20170206025544.3292-2-mikey@neuling.org>
 <87tw86g8t3.fsf@concordia.ellerman.id.au>
 <20170207075420.GJ4090@naverao1-tp.localdomain>
Date: Tue, 07 Feb 2017 22:00:02 +1100
Message-ID: <874m06b70t.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> On 2017/02/07 11:10AM, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> > diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
>> > index 7028dbc753..911b43e2c7 100644
>> > --- a/arch/powerpc/configs/powernv_defconfig
>> > +++ b/arch/powerpc/configs/powernv_defconfig
>> > @@ -79,6 +80,10 @@ CONFIG_NETFILTER=y
>> >  # CONFIG_NETFILTER_ADVANCED is not set
>> >  CONFIG_BRIDGE=m
>> >  CONFIG_VLAN_8021Q=m
>> > +CONFIG_NET_SCHED=y
>> > +CONFIG_NET_CLS_BPF=y
>> > +CONFIG_NET_CLS_ACT=y
>> > +CONFIG_NET_ACT_BPF=y
>> 
>> I'm inclined to make these =m.
>> 
>> I assume that would still work for bcc?
>
> Yes, that should work too.

> As an aside, I had sent a patch to enable BPF_SYSCALL across powernv, 
> pseries and ppc64 defconfigs:
> https://patchwork.ozlabs.org/patch/721997/

Thanks. That's better.

> It would be good to have the network related BPF configs enabled across 
> all three.

I'll mush the patches all together and turn them all on across
pseries/ppc64/powernv.

cheers
