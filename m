Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlmbN41l0zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 13:38:08 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id 184so41743154pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:38:08 -0700 (PDT)
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alistair Popple <alistair@popple.id.au>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0E13.6080409@ozlabs.ru> <20160413234246.GA5330@gwshan>
 <8771729.bnzLL9sLJY@new-mexico> <20160414013052.GA23214@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 grant.likely@linaro.org, robherring2@gmail.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, dja@axtens.net
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570F1098.2010100@ozlabs.ru>
Date: Thu, 14 Apr 2016 13:38:00 +1000
MIME-Version: 1.0
In-Reply-To: <20160414013052.GA23214@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/14/2016 11:30 AM, Gavin Shan wrote:
> On Thu, Apr 14, 2016 at 09:57:32AM +1000, Alistair Popple wrote:
>> Hi Gavin,
>>
>> <snip>
>>
>>>> Why exactly cannot EEH reset changes go to a smaller separate patchset
>>>> (before hotplug)?
>>>>
>>>
>>> As I explained before, the patchset's order is: PCI generic part,
>>> PowerNV PCI related, EEH related, device-tree part and hotplug driver.
>>>
>>> The EEH reset change is included in PATCH[37/45]. There is no point
>>> to reorder the patches.
>>
>> I don't understand all of the dependencies but if possible splitting the
>> series up into a set of smaller self-contained patch series makes things
>> easier to review and may make it easier for you to get this functionality
>> reviewed and accepted into upstream.
>>
>
> Thanks, Alistair. I will move those cleanup/refactor related patches
> to form a separate series which is expected to be merged first. That
> will helps the reviewers to focus on the patches with complicated
> changes as you suggested. Alexey, please let me know if that way is
> you like to see or not.

I do not know yet, I have not finished reviewing this version. May be the 
EEH reset patch depends on 1/45..36/45; or it only makes sense when 45/45 
is applied - this all is unclear.

If 37/45 has no dependencies and good just by itself, you could have posted 
it separately few months ago and it would have reached upstream by now and 
this patchset would be at least one patch shorter and you would not have to 
rebase all 45 patches over and over again on top of the current upstream 
tree...



-- 
Alexey
