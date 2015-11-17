Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78BB81A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:49 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:14:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4BFD42CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:45 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1ELZR33751244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:29 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1ECYA009455
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:13 +1100
Date: Tue, 17 Nov 2015 12:04:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
Message-ID: <20151117010446.GA26294@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D77.2060101@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D77.2060101@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:01:59PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>As we track M32 segment consumption, this introduces an array to
>>the PHB to track the mapping between M64 segment and PE number.
>>The information is going to be used to find M64 segment from the
>>PE number during PCI unplugging time in subsequent patches.
>
>
>It would not hurt to put a few words about how we managed to live without
>such a mapping for M64 before but we needed mapping for M32.
>

The M32 mapping (phb->ioda.m32_segmap[]) isn't used for anything before
this patcheset. There're no need for M64 mapping before this patchset
similarly, no need to add the words.

Thanks,
Gavin
