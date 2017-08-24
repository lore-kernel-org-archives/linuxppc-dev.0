Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xd7K26BmPzDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 12:19:18 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id w27so1687798pge.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 19:19:18 -0700 (PDT)
Subject: Re: [PATCH kernel 0/5] powerpc/eeh: Some cleanups
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <1503537218.14064.5.camel@russell.cc>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3fd12aab-9bbb-1f80-3750-f0e08a0a4d06@ozlabs.ru>
Date: Thu, 24 Aug 2017 12:19:10 +1000
MIME-Version: 1.0
In-Reply-To: <1503537218.14064.5.camel@russell.cc>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/08/17 11:13, Russell Currey wrote:
> On Wed, 2017-08-23 at 20:18 +1000, Alexey Kardashevskiy wrote:
>> Here are few patches to get rid of some cached pointers across EEH and
>> powernv code as I was struggling to figure out about lifetime of
>> structures and so on.
> 
> Thanks for the patches.  For the whole series:
> 
> Acked-by: Russell Currey <ruscur@russell.cc>


The patches are labelled as "Needs Review / ACK" in the patchworks, and
until you reply to each individual patch, the "A" part of the "A/R/T"
column will remain "- - -".


> 
>>
>>
>> This is based on sha1
>> 98b9f8a45499 Linus Torvalds Merge tag 'ext4_for_linus_stable' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (5):
>>   powerpc/pci: Remove unused parameter from add_one_dev_pci_data()
>>   powerpc/eeh: Reduce to one the number of places where edev is
>>     allocated
>>   powerpc/eeh: Remove unnecessary pointer to phb from eeh_dev
>>   powerpc/eeh: Remove unnecessary config_addr from eeh_dev
>>   powerpc/eeh: Remove unnecessary node from pci_dn
>>
>>  arch/powerpc/include/asm/eeh.h               |  5 +-
>>  arch/powerpc/include/asm/pci-bridge.h        |  1 -
>>  arch/powerpc/kernel/eeh.c                    | 16 ++---
>>  arch/powerpc/kernel/eeh_dev.c                |  2 -
>>  arch/powerpc/kernel/eeh_driver.c             |  2 +-
>>  arch/powerpc/kernel/eeh_pe.c                 | 90 ++++++++++++++++-----------
>> -
>>  arch/powerpc/kernel/eeh_sysfs.c              |  3 -
>>  arch/powerpc/kernel/pci_dn.c                 | 22 +++----
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 29 +++------
>>  9 files changed, 78 insertions(+), 92 deletions(-)
>>
> 


-- 
Alexey
