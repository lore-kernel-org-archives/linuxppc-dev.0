Return-Path: <kda@linux-powerpc.org>
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com
 [209.85.219.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 172D81A0011
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 01:43:15 +1000 (EST)
Received: by mail-oa0-f49.google.com with SMTP id i7so4090279oag.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 08:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403771455.18572.8.camel@concordia>
References: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
 <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
 <1403771455.18572.8.camel@concordia>
Date: Thu, 26 Jun 2014 19:43:12 +0400
Message-ID: <CAOJe8K0qhOv-zP3BLihvxvt7_b+PHtStommdXzN=-7iLe7sLvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc: bpf: Fix the broken LD_VLAN_TAG_PRESENT
 test
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/26/14, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2014-06-25 at 21:34 +0400, Denis Kirjanov wrote:
>> We have to return the boolean here if the tag presents
>> or not, not just ANDing the TCI with the mask which results to:
>>
>> [  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
>> [  709.412245] ret 4096 != 1
>> [  709.412332] ret 4096 != 1
>> [  709.412333] FAIL (2 times)
>
> Hi Denis,
>
> Is this the same version of test_bpf that is in Linus' tree?

You didn't enable the JIT.
> I don't see any fails with that version, am I missing something?
>
>   [  187.690640] test_bpf: #18 LD_VLAN_TAG_PRESENT 46 50 PASS
>
> cheers
>
>
>
