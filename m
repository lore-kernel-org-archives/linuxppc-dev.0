Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3c4Z4FX6zDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:10:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Cc: Rashmica Gupta <rashmica.g@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 8/9] powerpc/mm: Wire up hpte_removebolted for powernv
In-Reply-To: <CAOSf1CHr2uMC1f5fMkqVpS7-J1K20cHShjp7FcNawV2KL4D_Dw@mail.gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-9-oohall@gmail.com>
 <1491961986.8380.13.camel@gmail.com>
 <CAOSf1CHr2uMC1f5fMkqVpS7-J1K20cHShjp7FcNawV2KL4D_Dw@mail.gmail.com>
Date: Thu, 13 Apr 2017 20:10:53 +1000
Message-ID: <8760i8aa8i.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:
> On Wed, Apr 12, 2017 at 11:53 AM, Balbir Singh <bsingharora@gmail.com> wrote:
>>
>> The API also does not clear linear_map_hash_slots[] under DEBUG_PAGEALLOC
>
> I'm not sure what API you're referring to here. The tracking for
> linear_map_hash_slots[] is agnostic of mmu_hash_ops so we shouldn't be
> touching it here. It also looks like DEBUG_PAGEALLOC is a bit broken
> with hotplugged memory anyway so I think that's a fix for a different
> patch.

It's old and has probably bit-rotted, so I'm happy for it to be fixed up
later if necessary.

cheers
