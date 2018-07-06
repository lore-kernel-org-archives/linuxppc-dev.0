Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41McCX1v8FzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 00:13:43 +1000 (AEST)
Subject: Re: [PATCH V2 00/10] KASan ppc64 support
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyMBnGJyBCoq2n9YSgC73GXr9-w3SjCTVdfz++drzOVGw@mail.gmail.com>
 <87k2sic6pw.fsf@linux.vnet.ibm.com>
 <7d459964-ce68-db1c-3d28-ae206d5ebdb0@c-s.fr>
 <87h8lch2t2.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <22bcc719-daeb-4e82-9e9e-e8a82ad72a1e@c-s.fr>
Date: Fri, 6 Jul 2018 16:13:37 +0200
MIME-Version: 1.0
In-Reply-To: <87h8lch2t2.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/07/2018 à 16:11, Aneesh Kumar K.V a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Hi Aneesh,
>>
>> Are you still working on support for KASan for ppc64 ?
>>
> 
> Haven't got time to work on this. The hash memory layout makes it
> a bit complicated to implement this.
> 

Ok, maybe would be easier to start with nohash.

Is there some literature somewhere about what an arch has to implement 
to use KAsan ?

Thanks,
Christophe
