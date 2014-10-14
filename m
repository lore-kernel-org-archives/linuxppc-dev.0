Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 636441A06DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 17:25:53 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 14 Oct 2014 11:55:46 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 93DA8E0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 11:55:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9E6QDUn51445790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 11:56:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9E6PeWs026614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 11:55:42 +0530
Date: Tue, 14 Oct 2014 14:25:39 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: michaele@au1.ibm.com
Subject: Re: [PATCH] powerpc/pci: remove duplicate declaration of
 pci_bus_find_capability
Message-ID: <20141014062539.GA5639@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1411118722-6590-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140919101802.GA7107@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140919101802.GA7107@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2014 at 08:18:02PM +1000, Gavin Shan wrote:
>On Fri, Sep 19, 2014 at 05:25:22PM +0800, Wei Yang wrote:
>>pci_bus_find_capability() is decleared in pci.h, so it is not necessary to do
>>it again.
>>
>>This patch removes it.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Thanks,
>Gavin

Hi, Michael

I see this is not merged in your tree. Do you have some comment?

>
>>---
>> arch/powerpc/kernel/pci-common.c |    1 -
>> 1 file changed, 1 deletion(-)
>>
>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>index b2814e2..9cfa069 100644
>>--- a/arch/powerpc/kernel/pci-common.c
>>+++ b/arch/powerpc/kernel/pci-common.c
>>@@ -1561,7 +1561,6 @@ EARLY_PCI_OP(write, byte, u8)
>> EARLY_PCI_OP(write, word, u16)
>> EARLY_PCI_OP(write, dword, u32)
>>
>>-extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
>> int early_find_capability(struct pci_controller *hose, int bus, int devfn,
>> 			  int cap)
>> {
>>-- 
>>1.7.9.5
>>

-- 
Richard Yang
Help you, Help me
