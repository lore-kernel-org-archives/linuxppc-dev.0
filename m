Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1CdH1vQqzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:41:23 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 May 2016 10:41:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9693E3578058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:41:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u460fAPv8782324
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:41:18 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u460ejDj022547
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:40:46 +1000
Date: Fri, 6 May 2016 10:40:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au
Subject: Re: [PATCH v9 21/22] drivers/of: Export of_detach_node()
Message-ID: <20160506004020.GA14869@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160504133603.GA30081@gwshan>
 <20160505194235.GA13790@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160505194235.GA13790@rob-hp-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2016 at 02:42:35PM -0500, Rob Herring wrote:
>On Wed, May 04, 2016 at 11:36:03PM +1000, Gavin Shan wrote:
>> On Tue, May 03, 2016 at 11:22:52PM +1000, Gavin Shan wrote:
>> >This exports of_detach_node() for PowerPC PowerNV PCI hotplug
>> >driver. No functional changes introduced.
>> >
>> >Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> 
>> Rob, I'm not sure it's late to cache the 4.7 merge window.
>> Also, I was told this series is needed by new CAPI driver which
>> is being developed. The developers hope to push the new CAPI driver
>> in 4.8 merge window (perhaps) or linux-next before 4.8 merge window
>> is opened. It means the new CAPI driver depends on this series which
>> has to be pushed to linux-next before 4.8 merge window.
>> 
>> If it's fine, could you please merge 16 to 21? With them merged to
>> 4.7, the left patches won't depend on FDT changes. Thanks in advance
>> for your help.
>
>I've applied the 6 patches.
>

Rob, thank you very much for your helps!

Thanks,
Gavin

>Rob
>
