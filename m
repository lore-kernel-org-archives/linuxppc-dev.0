Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSQMG4mL1zDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 17:05:46 +1000 (AEST)
Date: Wed, 17 May 2017 09:04:26 +0200
Message-ID: <20170517090426.Horde.eql6xxQwhPON3qTdB7H6SA6@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC 0/2] Consolidate patch_instruction
References: <20170516222015.Horde.fwWhnIwI59SuB64Du97wdg2@messagerie.c-s.fr>
 <1494987032.30802.6.camel@gmail.com>
In-Reply-To: <1494987032.30802.6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> a =C3=A9crit=C2=A0:

> On Tue, 2017-05-16 at 22:20 +0200, LEROY Christophe wrote:
>> Balbir Singh <bsingharora@gmail.com> a =C3=A9crit=C2=A0:
>>
>> > patch_instruction is enhanced in this RFC to support
>> > patching via a different virtual address (text_poke_area).
>> > The mapping of text_poke_area->addr is RW and not RWX.
>> > This way the mapping allows write for patching and then we tear
>> > down the mapping. The downside is that we introduce a spinlock
>> > which serializes our patching to one patch at a time.
>>
>> Very nice patch, would fit great with my patch for impmementing
>> CONFIG_DEBUG_RODATA (https://patchwork.ozlabs.org/patch/754289 ).
>> Would avoid having to set the text area back to RW for patching
>>
>
> Awesome! It seems like you have some of the work for CONFIG_STRICT_KERNEL=
_RWX
> any reason why this is under CONFIG_DEBUG_RODATA? But I think there is
> reuse capability across the future patches and the current set.
>

Indeed it looks the same, see https://patchwork.kernel.org/patch/9554881

Christophe


> Cheers,
> Balbir  Singh.
