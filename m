Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qljnm4GZjzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:31:56 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 Apr 2016 11:31:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9FDB22CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:31:50 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3E1Vgiv56361118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:31:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3E1VHFd009097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 11:31:18 +1000
Date: Thu, 14 Apr 2016 11:30:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, devicetree@vger.kernel.org,
 grant.likely@linaro.org, robherring2@gmail.com,
 linux-pci@vger.kernel.org, bhelgaas@google.com, dja@axtens.net
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
Message-ID: <20160414013052.GA23214@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0E13.6080409@ozlabs.ru> <20160413234246.GA5330@gwshan>
 <8771729.bnzLL9sLJY@new-mexico>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8771729.bnzLL9sLJY@new-mexico>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 14, 2016 at 09:57:32AM +1000, Alistair Popple wrote:
>Hi Gavin,
>
><snip>
>
>> >Why exactly cannot EEH reset changes go to a smaller separate patchset
>> >(before hotplug)?
>> >
>> 
>> As I explained before, the patchset's order is: PCI generic part,
>> PowerNV PCI related, EEH related, device-tree part and hotplug driver.
>> 
>> The EEH reset change is included in PATCH[37/45]. There is no point
>> to reorder the patches.
>
>I don't understand all of the dependencies but if possible splitting the 
>series up into a set of smaller self-contained patch series makes things 
>easier to review and may make it easier for you to get this functionality 
>reviewed and accepted into upstream.
>

Thanks, Alistair. I will move those cleanup/refactor related patches
to form a separate series which is expected to be merged first. That
will helps the reviewers to focus on the patches with complicated
changes as you suggested. Alexey, please let me know if that way is
you like to see or not.

Thanks,
Gavin

>Regards,
>
>Alistair
>
