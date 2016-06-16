Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVNzS4N73zDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 10:09:24 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id t190so13618254pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 17:09:24 -0700 (PDT)
Subject: Re: [PATCH] Add support for power9 in ibm_architecture_vec
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
 <87k2hqaegk.fsf@skywalker.in.ibm.com>
 <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
 <87h9cua1fl.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8d2526bd-1f31-bcfc-d188-5b15cb0624e8@gmail.com>
Date: Thu, 16 Jun 2016 10:09:15 +1000
MIME-Version: 1.0
In-Reply-To: <87h9cua1fl.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/06/16 01:58, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On Wed, Jun 15, 2016 at 9:17 PM, Aneesh Kumar K.V
>> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>> Shouldn't this be 125 + 16 ?
>>
>> Actually the previous patch broke it and Ben fixed it, it should have
>> been 133 after adding POWER8NVL. My patch adds 16+1 (1 for the
>> OV1_PPC_3_00)
>>
>> 133+17 = 150
>>
>> Michael, can you please check. I did a quick check with  gdb
>>
> 
> 
> I missed that  OV1_PPC_3_00 is byte 3 of option vection 1. I guess you
> also need to update VECTOR_LENGHT above the option vector 1 to 3.
> ie, it should be VECTOR_LENGTH(3) ?
Yes, my bad.. I'll respin. I thought I had it, but I clearly did not

Balbir
