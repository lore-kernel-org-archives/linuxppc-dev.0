Return-Path: <rashmicy@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2qDx4fppzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 13:30:25 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id o123so2724474pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:30:25 -0700 (PDT)
Subject: Re: [PATCH 8/9] powerpc/mm: Wire up hpte_removebolted for powernv
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Oliver O'Halloran <oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-9-oohall@gmail.com> <20170412085056.4da27f32@kryten>
 <20170412101819.402451e0@canb.auug.org.au>
Cc: Anton Blanchard <anton@samba.org>, Rashmica Gupta <rashmica.g@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
From: Rashmica Gupta <rashmicy@gmail.com>
Message-ID: <ca08ec04-5e59-cfa5-3682-eeba7cc3b58e@gmail.com>
Date: Wed, 12 Apr 2017 13:30:18 +1000
MIME-Version: 1.0
In-Reply-To: <20170412101819.402451e0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/04/17 10:18, Stephen Rothwell wrote:
> Hi Oliver,
>
> On Wed, 12 Apr 2017 08:50:56 +1000 Anton Blanchard <anton@samba.org> wrote:
>>> From: Rashmica Gupta <rashmica.g@gmail.com>
>>>
>>> Adds support for removing bolted (i.e kernel linear mapping) mappings
>>> on powernv. This is needed to support memory hot unplug operations
>>> which are required for the teardown of DAX/PMEM devices.
>>>
>>> Cc: Rashmica Gupta <rashmica.g@gmail.com>
>>> Cc: Anton Blanchard <anton@samba.org>
>>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>>> ---
>>> Could the original author of this add their S-o-b? I pulled it out of
>>> Rashmica's memtrace patch, but I remember someone saying Anton wrote
>>> it originally.
>> I did.
>>
>> Signed-off-by: Anton Blanchard <anton@samba.org>
> If you are going to claim that Rashmica authored this patch (and you do
> with the From: line above), then you need her Signed-off-by as well.
>
Oliver, can you change the 'From' to a 'Reviewed By'?
