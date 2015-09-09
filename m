Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7275F1A2B0A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 15:22:16 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so149351268pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2015 22:22:14 -0700 (PDT)
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
To: Richard Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150729031718.GA18069@richard> <20150909024820.GA6808@gwshan>
 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
Cc: bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55EFC200.10209@ozlabs.ru>
Date: Wed, 9 Sep 2015 15:22:08 +1000
MIME-Version: 1.0
In-Reply-To: <20150909033616.GA5148@richards-mbp.cn.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/2015 01:36 PM, Richard Yang wrote:
> On Wed, Sep 09, 2015 at 12:48:21PM +1000, Gavin Shan wrote:
>> On Wed, Jul 29, 2015 at 11:17:18AM +0800, Wei Yang wrote:
>>> Hi, Michael
>>>
>>> Hope you didn't take this yet. We may change this patch a little.
>>>
>>
>> [Cc Alexey who might concern the SRIOV status]
>>
>> Richard, do you have plan to get it upstream? It seems it's hanged
>> over here for long time.
>>
>
> The VF EEH is hung since we re-designed the SRIOV. After the re-design, we
> don't have VF groups.
>
> My plan is to push the VF EEH patch set after the SRIOV Redesign is accepted.


Can you please rebase on v4.2 (or v4.2 + sriov rework) and repost VF EEH 
patchset just to me? Or share the tree somewhere where I can pull it from? 
Thanks.

As for now, I cannot tell what difference your SRIOV patchset actually makes.

-- 
Alexey
