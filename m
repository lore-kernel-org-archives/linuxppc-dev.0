Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6A6A1A067A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 17:41:31 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 14 Oct 2014 12:11:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A75451258043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 12:11:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9E6hdHW5767628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 12:13:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9E6fM6Q017521
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 12:11:23 +0530
Date: Tue, 14 Oct 2014 14:41:21 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: michaele@au1.ibm.com
Subject: Re: [PATCH] powerpc/pci: remove duplicate declaration of
 pci_bus_find_capability
Message-ID: <20141014064121.GA7990@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1411118722-6590-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140919101802.GA7107@shangw> <20141014062539.GA5639@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141014062539.GA5639@richard>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2014 at 02:25:39PM +0800, Wei Yang wrote:
>On Fri, Sep 19, 2014 at 08:18:02PM +1000, Gavin Shan wrote:
>>On Fri, Sep 19, 2014 at 05:25:22PM +0800, Wei Yang wrote:
>>>pci_bus_find_capability() is decleared in pci.h, so it is not necessary to do
>>>it again.
>>>
>>>This patch removes it.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>Thanks,
>>Gavin
>
>Hi, Michael
>
>I see this is not merged in your tree. Do you have some comment?
>

Oops,

As pointed by Gavin, it is in the next branch.

>>
>>>---
>>> arch/powerpc/kernel/pci-common.c |    1 -
>>> 1 file changed, 1 deletion(-)
>>>
>>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>>index b2814e2..9cfa069 100644
>>>--- a/arch/powerpc/kernel/pci-common.c
>>>+++ b/arch/powerpc/kernel/pci-common.c
>>>@@ -1561,7 +1561,6 @@ EARLY_PCI_OP(write, byte, u8)
>>> EARLY_PCI_OP(write, word, u16)
>>> EARLY_PCI_OP(write, dword, u32)
>>>
>>>-extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
>>> int early_find_capability(struct pci_controller *hose, int bus, int devfn,
>>> 			  int cap)
>>> {
>>>-- 
>>>1.7.9.5
>>>
>
>-- 
>Richard Yang
>Help you, Help me

-- 
Richard Yang
Help you, Help me
