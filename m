Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7A1F1A0484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 10:29:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 17 Sep 2015 10:29:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 428342BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 10:29:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8H0TCS559965688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 10:29:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8H0Sv2a013528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 10:28:57 +1000
Date: Thu, 17 Sep 2015 10:28:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
Message-ID: <20150917002832.GA2034@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150729031718.GA18069@richard> <20150909024820.GA6808@gwshan>
 <20150909033616.GA5148@richards-mbp.cn.ibm.com>
 <55EFC200.10209@ozlabs.ru>
 <20150909060129.GC7684@Richards-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150909060129.GC7684@Richards-MacBook-Pro.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 09, 2015 at 02:01:29PM +0800, Richard Yang wrote:
>On Wed, Sep 09, 2015 at 03:22:08PM +1000, Alexey Kardashevskiy wrote:
>>On 09/09/2015 01:36 PM, Richard Yang wrote:
>>>On Wed, Sep 09, 2015 at 12:48:21PM +1000, Gavin Shan wrote:
>>>>On Wed, Jul 29, 2015 at 11:17:18AM +0800, Wei Yang wrote:
>>>>>Hi, Michael
>>>>>
>>>>>Hope you didn't take this yet. We may change this patch a little.
>>>>>
>>>>
>>>>[Cc Alexey who might concern the SRIOV status]
>>>>
>>>>Richard, do you have plan to get it upstream? It seems it's hanged
>>>>over here for long time.
>>>>
>>>
>>>The VF EEH is hung since we re-designed the SRIOV. After the re-design, we
>>>don't have VF groups.
>>>
>>>My plan is to push the VF EEH patch set after the SRIOV Redesign is accepted.
>>
>>
>>Can you please rebase on v4.2 (or v4.2 + sriov rework) and repost VF EEH
>>patchset just to me? Or share the tree somewhere where I can pull it from?
>>Thanks.
>>
>
>Yep, this is what I am planning to do.
>

Can you rebase your patchset on v4.3.rc1+sriov rework and then repost to
linux-ppc-dev maillist?


>>As for now, I cannot tell what difference your SRIOV patchset actually makes.
>>
>>-- 
>>Alexey
>
>-- 
>Richard Yang
>Help you, Help me
